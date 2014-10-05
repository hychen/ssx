var ref$, div, h2, a, p, span, article, header, prelude, List, Blogroll;
ref$ = React.DOM, div = ref$.div, h2 = ref$.h2, a = ref$.a, p = ref$.p, span = ref$.span, article = ref$.article, header = ref$.header;
prelude = require('prelude-ls');
List = React.createClass({
  render: function(){
    var posts;
    posts = prelude.objToPairs(this.props.items).reverse();
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
        }, div({}, header({}, h2({}, v.title), span({
          className: 'byline'
        }, v.author + ""))), div({
          dangerouslySetInnerHTML: {
            __html: v.summary
          }
        }, null), a({
          href: v.link
        }, 'more'));
      }
    }.call(this))));
  }
});
Blogroll = React.createClass({
  mixins: [ReactFireMixin],
  getInitialState: function(){
    return {
      items: []
    };
  },
  componentWillMount: function(){
    var ref;
    ref = new Firebase("https://ssx.firebaseio.com/blog/");
    return this.bindAsArray(ref.limit(1), 'items');
  },
  render: function(){
    if (this.state.items.length === 0) {
      return div({
        className: "container box-feature3"
      }, 'Loading...');
    } else {
      return List({
        items: this.state.items[0]
      });
    }
  }
});
React.renderComponent(Blogroll(), document.getElementById('blogroll'));