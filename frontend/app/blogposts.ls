{div, h2, a, p, span, article, header} = React.DOM

List = React.createClass do
  render: ->
    div {className:\box-article-list}, 
      ... for let k,v of @props.items
        article {key:k},
          div {},
            header {},
              h2 {}, v.title
              span {className:\byline}, "#{v.author}" 
          div {dangerouslySetInnerHTML:{__html:v.summary}}, null
          a {href:v.link}, \more

Blogroll = React.createClass do
  mixins: [ReactFireMixin],
  getInitialState: -> do
    items: []
  componentWillMount: ->
    ref = new Firebase "https://ssx.firebaseio.com/blog/"
    @bindAsArray(ref.limit(1), \items)
  render: ->
    if @state.items.length == 0
      div {className:"container box-feature3"}, 'Loading...'
    else
      List {items: @state.items.0}

React.renderComponent Blogroll!, document.getElementById('blogroll')