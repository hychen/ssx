{div, h4, a, p, img, span, article, header} = React.DOM
prelude = require 'prelude-ls'

d = ->
  new Date it .toLocaleDateString!

EventsList = React.createClass do
  render: ->
    #posts = prelude.obj-to-pairs @props.items .reverse!
    posts = @props.items .reverse!
    if posts.length > 3
      posts = posts[0 to 2]
    div {className:\box-article-list}, 
      ... for let v, i in posts
        article {key:i},
          header {}, 
            h4 {}, a {href:v.url}, $('<div/>').html(v.title).text!
            span {className:\byline}, v.start 

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
              a {href:v.link}, $('<div/>').html(v.title).text!
            span {className:\byline}, "#{d v.pubdate}"

InfoBox = React.createClass do
  mixins: [ReactFireMixin],
  getDefaultProps: -> do
    collectionname: null    
  getInitialState: -> do
    items: []
  componentWillMount: ->
    match @props.collectionname
    | /blog/ =>
      ref = new Firebase "https://ssx.firebaseio.com/#{@props.collectionname}/"
      @bindAsArray(ref.limit(3), \items)
    | /events/ =>
      <- $.ajax do
        url: '/events.json'
        type: 'GET'
        dateType: 'JSON'
        success: ~> 
          @setState items: it
        error: -> console.error "load event data failed."
  render: ->
    if @state.items.length == 0
      div {className:"container"}, 
        img {src:'/images/spin-pacman.gif'}, null
    else
      match @props.collectionname
      | /blog/ => BlogPostsList {items: @state.items.0}
      | /events/ => EventsList {items: @state.items}
      | _ => console.error 'unsupported collection type #{it}'
