###* @jsx React.DOM ###

NewBookmarkForm = React.createClass
  getInitialState: ->
    {
      url: ''
      title: ''
      tags: []
      description: ''
    }

  render: ->

  urlChanged: ->
    alert('Changed!')