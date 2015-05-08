Bookmark = React.createClass
  getInitialState: ->
    {
      collapsed: true
    }
  render: ->
    <div className={ @bookmarkClassName() }>
      <a className="collapse-trigger" onClick={ @toggleCollapse }>
        <i className={ @chevronClassName() }></i>
      </a>

      <div className="thumbnail pull-right">
        <img src={ @props.model.thumbnail } alt="" width="300" height="225"/>
      </div>

      <div className="content">
        <h1>
          <a href={ @props.model.url }>{ @props.model.title }
            <i>{ @props.model.url }</i></a>
        </h1>
        <div className="description">
          { @props.model.description }
        </div>
        { @renderTags() if @props.model.tags }
      </div>
    </div>

  renderTags: ->
    <div className="tags">
      { @renderTag(tag) for tag in @props.model.tags }
    </div>

  renderTag: (tag) ->
    <a key={ tag } href={ '#search=tag:' + tag }><span className="label label-default">{ tag }</span></a>

  toggleCollapse: (event) ->
    $button = $(event.target)
    $button.parents('.panel-bookmark').toggleClass('')
    @setState(collapsed: !@state.collapsed)

  bookmarkClassName: ->
    className = "panel panel-default panel-bookmark"
    className += " panel-bookmark-collapsed" if @state.collapsed
    className

  chevronClassName: ->
    "glyphicon glyphicon-chevron-" + (if @state.collapsed then 'down' else 'up')

window.Bookmark = Bookmark

