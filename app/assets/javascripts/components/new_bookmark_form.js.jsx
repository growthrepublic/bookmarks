var NewBookmarkForm = React.createClass({
  propTypes: {
    url: React.PropTypes.string,
    title: React.PropTypes.string,
    tags: React.PropTypes.string,
    description: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Url: {this.props.url}</div>
        <div>Title: {this.props.title}</div>
        <div>Tags: {this.props.tags}</div>
        <div>Description: {this.props.description}</div>
      </div>
    );
  }
});
