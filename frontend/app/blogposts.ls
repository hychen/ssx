{div, h2, a, p, img, span, article, header} = React.DOM
prelude = require 'prelude-ls'

List = React.createClass do
  render: ->
    posts = prelude.obj-to-pairs @props.items .reverse!
    div {className:\box-article-list}, 
      ... for let [k,v] in posts
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
    @bindAsArray(ref.limit(3), \items)
  render: ->
    if @state.items.length == 0
      div {className:"container box-feature3"}, 
        img {src:'/images/spin-pacman.gif'}, null
    else
      List {items: @state.items.0}

React.renderComponent Blogroll!, document.getElementById('blogroll')