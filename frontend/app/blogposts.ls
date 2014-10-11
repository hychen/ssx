{div, h4, a, p, img, span, article, header} = React.DOM
prelude = require 'prelude-ls'

d = ->
  new Date it .toLocaleDateString!

EventsList = React.createClass do
  render: ->
    posts = prelude.obj-to-pairs @props.items .reverse!
    if posts.length > 3
      posts = posts[0 to 2]
    div {className:\box-article-list}, 
      ... for let [k,v] in posts
        article {key:k},
          header {},
            h4 {}, a {href:v.link}, v.title
            span {}, "#{d v.pubdate}"

BlogPostsList = React.createClass do
  render: ->
    posts = prelude.obj-to-pairs @props.items .reverse!
    if posts.length > 3
      posts = posts[0 to 2]
    div {className:\box-article-list}, 
      ... for let [k,v] in posts
        article {key:k},
          header {},
            h4 {}, 
              a {href:v.link}, v.title
            span {className:\byline}, "#{d v.pubdate} #{v.author}" 

InfoBox = React.createClass do
  mixins: [ReactFireMixin],
  getDefaultProps: -> do
    collectionname: null    
  getInitialState: -> do
    items: []
  componentWillMount: ->
    ref = new Firebase "https://ssx.firebaseio.com/#{@props.collectionname}/"
    @bindAsArray(ref.limit(3), \items)
  render: ->
    if @state.items.length == 0
      div {className:"container"}, 
        img {src:'/images/spin-pacman.gif'}, null
    else
      match @props.collectionname
      | /blog/ => BlogPostsList {items: @state.items.0}
      | /events/ => EventsList {items: @state.items.0}
      | _ => console.error 'unsupported collection type #{it}'

React.renderComponent InfoBox({collectionname:'events'}), document.getElementById('events')
React.renderComponent InfoBox({collectionname:'blog'}), document.getElementById('blogposts')