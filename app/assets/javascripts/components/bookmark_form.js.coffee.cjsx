BookmarkForm = React.createClass
  getInitialState: ->
    {
      url: ''
      title: ''
      tags: []
      description: ''
      advanced_options: false
    }

  render: ->
    <div className="panel panel-default">
      <div className="panel-body">
        <form action="">
          <div className="form-group">
            <div className="input-group">
              <input name="url" type="text" className="form-control" placeholder="URL..." value={@state.url} onBlur={@urlChanged}/>
              <span className="input-group-btn">
                <button className="btn btn-primary" type="submit">Add</button>
              </span>
            </div>
          </div>
          <div className="form-group">
            <button className="btn btn-default btn-xs" onClick={@toggleAdvancedOptions}>Advanced settings</button>
          </div>
          { @advancedOptions() if @state.advanced_options }
        </form>
      </div>
    </div>

  advancedOptions: ->
    <div className="advanced-options">
      <div className="form-group">
        <input name="title" className="form-control" type="text" placeholder="Title"/>
      </div>
      <div className="form-group">
        <input name="tags" className="form-control" type="text" placeholder="Tags, comma separated"/>
      </div>
      <div className="form-group">
        <textarea name="description" className="form-control textarea-lg" type="text" placeholder="Description"></textarea>
      </div>
    </div>

  urlChanged: (event) ->
    @setState(url: event.target.value)

  toggleAdvancedOptions: (event) ->
    event.preventDefault()
    @setState(advanced_options: !@state.advanced_options)

window.BookmarkForm = BookmarkForm