{div, h2, p} = React.DOM

BlogPost = React.createClass do 
  render: ->
    h2 {}, 'title'
    p {}, 'summary'
    div {}, 'hiihihiii'

BlogPosts = React.createClass do
  render: ->
    p {}, 'hihihihihi'

React.renderComponent BlogPosts!, document.getElementById('blogposts')