var ref$, div, h2, p, BlogPost, BlogPosts;
ref$ = React.DOM, div = ref$.div, h2 = ref$.h2, p = ref$.p;
BlogPost = React.createClass({
  render: function(){
    h2({}, 'title');
    p({}, 'summary');
    return div({}, 'hiihihiii');
  }
});
BlogPosts = React.createClass({
  render: function(){
    return p({}, 'hihihihihi');
  }
});
React.renderComponent(BlogPosts(), document.getElementById('blogposts'));