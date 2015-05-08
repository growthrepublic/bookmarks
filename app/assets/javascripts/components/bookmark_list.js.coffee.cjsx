BookmarkList = React.createClass
  getInitialState: ->
    {
      search_query: ''
    }

  render: ->
    <div className="bookmark-list">
      <div className="panel panel-default">
        <div className="panel-body">
          <form action="">
            <div className="form-group">
              <div className="input-group">
                <input name="url" type="text" className="form-control" placeholder="A phrase, fragment of description, tag or URL..."/>
                <span className="input-group-btn">
                  <button className="btn btn-primary" type="submit">Search</button>
                </span>
              </div>
            </div>
          </form>
        </div>
      </div>
      <hr/>
      <div>{ @renderBookmark(model) for model in @props.bookmarks }</div>
    </div>

  renderBookmark: (model) ->
    <Bookmark key={model.id} model={model} />

window.BookmarkList = BookmarkList