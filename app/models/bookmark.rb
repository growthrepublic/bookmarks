# == Schema Information
#
# Table name: bookmarks
#
#  id          :integer          not null, primary key
#  url         :string           not null
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  thumbnail   :string
#

class Bookmark < ActiveRecord::Base
  before_create :fetch_metadata
  after_create :create_thumbnail_in_background
  after_destroy :remove_thumbnail

  validate :url_format

  acts_as_taggable

  def url_format
    !!URI.parse(url) rescue false
  end

  def fetch_metadata
    return if self.title.present? && self.description.present?

    scrapper = PageScrapper.new(url)
    self.title       ||= scrapper.title
    self.description ||= scrapper.description
    self.tag_list      = scrapper.tags.join(',') if self.tag_list.blank?
  end

  def create_thumbnail_in_background
    self.class.delay.create_thumbnail!(id)
  end

  def self.create_thumbnail!(id)
    find(id).create_thumbnail!
  end

  def create_thumbnail!
    old_filename = read_attribute(:thumbnail)
    filename = SecureRandom.hex(24) + '.jpg'

    Screencap::Fetcher.new(url).fetch(
      output: Rails.root.join('public', 'screenshots', filename),
      width: 1024,
      height: 768
    )
    update_attributes!(thumbnail: filename)
    if old_filename.present? && File.exists?(Rails.root.join('public', 'screenshots', old_filename))
      FileUtils.rm Rails.root.join('public', 'screenshots', old_filename)
    end
  end

  def serializable_hash(options={})
    hsh = super(options)
    hsh['tags'] = tag_list if hsh['tags'].blank?
    hsh
  end

  def remove_thumbnail
    if thumbnail.present? && File.exists?(Rails.root.join('public', 'screenshots', thumbnail))
      FileUtils.rm Rails.root.join('public', 'screenshots', thumbnail)
    end
  end
end
