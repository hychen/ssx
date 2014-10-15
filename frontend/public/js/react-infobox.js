var ref$, div, h4, a, p, img, span, article, header, prelude, d, EventsList, BlogPostsList, InfoBox;
ref$ = React.DOM, div = ref$.div, h4 = ref$.h4, a = ref$.a, p = ref$.p, img = ref$.img, span = ref$.span, article = ref$.article, header = ref$.header;
prelude = require('prelude-ls');
d = function(it){
  return new Date(it).toLocaleDateString();
};
EventsList = React.createClass({
  render: function(){
    var posts;
    posts = this.props.items.reverse();
    if (posts.length > 3) {
      posts = [posts[0], posts[1], posts[2]];
    }
    return div.apply(null, [{
      className: 'box-article-list'
    }].concat((function(){
      var i$, len$, results$ = [];
      for (i$ = 0, len$ = posts.length; i$ < len$; ++i$) {
        results$.push((fn$.call(this, i$, posts[i$])));
      }
      return results$;
      function fn$(i, v){
        return article({
          key: i
        }, header({}, h4({}, a({
          href: v.url
        }, v.title)), span({}, v.start)));
      }
    }.call(this))));
  }
});
BlogPostsList = React.createClass({
  render: function(){
    var posts;
    posts = prelude.objToPairs(this.props.items).reverse();
    if (posts.length > 3) {
      posts = [posts[0], posts[1], posts[2]];
    }
    return div.apply(null, [{
      className: 'box-article-list'
    }].concat((function(){
      var i$, len$, results$ = [];
      for (i$ = 0, len$ = posts.length; i$ < len$; ++i$) {
        results$.push((fn$.call(this, posts[i$])));
      }
      return results$;
      function fn$(arg$){
        var k, v;
        k = arg$[0], v = arg$[1];
        return article({
          key: k
        }, header({}, h4({}, a({
          href: v.link
        }, v.title)), span({
          className: 'byline'
        }, d(v.pubdate) + " " + v.author)));
      }
    }.call(this))));
  }
});
InfoBox = React.createClass({
  mixins: [ReactFireMixin],
  getDefaultProps: function(){
    return {
      collectionname: null
    };
  },
  getInitialState: function(){
    return {
      items: []
    };
  },
  componentWillMount: function(){
    var ref$, ref, this$ = this;
    switch (ref$ = [this.props.collectionname], false) {
    case !/blog/.test(ref$[0]):
      ref = new Firebase("https://ssx.firebaseio.com/" + this.props.collectionname + "/");
      return this.bindAsArray(ref.limit(3), 'items');
    case !/events/.test(ref$[0]):
      return $.ajax({
        url: '/events.json',
        type: 'GET',
        dateType: 'JSON',
        success: function(it){
          return this$.setState({
            items: it
          });
        },
        error: function(){
          return console.error("load event data failed.");
        }
      }, function(){});
    }
  },
  render: function(){
    var ref$;
    if (this.state.items.length === 0) {
      return div({
        className: "container"
      }, img({
        src: '/images/spin-pacman.gif'
      }, null));
    } else {
      switch (ref$ = [this.props.collectionname], false) {
      case !/blog/.test(ref$[0]):
        return BlogPostsList({
          items: this.state.items[0]
        });
      case !/events/.test(ref$[0]):
        return EventsList({
          items: this.state.items
        });
      default:
        return console.error('unsupported collection type #{it}');
      }
    }
  }
});