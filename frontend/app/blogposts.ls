{div, h2, p, a} = React.DOM

List = React.createClass do
  render: ->
    div {}, 
      ... for let k,v of @props.items
        div {key:k}, 
          h2 {}, v.title
          p {dangerouslySetInnerHTML:{__html:v.description}}, null
          p {},
            a {href:v.link}, \More

Blogroll = React.createClass do
  mixins: [ReactFireMixin],
  getInitialState: -> do
    items: []
  componentWillMount: ->
    ref = new Firebase "https://ssx.firebaseio.com/blog/"
    @bindAsArray ref.limit(3), \items
  render: ->
    if @state.items.length == 0
      div {}, 'Loading...'
    else
      List {items: @state.items.0}

React.renderComponent Blogroll!, document.getElementById('blogroll')