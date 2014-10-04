var ref$, div, h2, p, a, List, Blogroll;
ref$ = React.DOM, div = ref$.div, h2 = ref$.h2, p = ref$.p, a = ref$.a;
List = React.createClass({
  render: function(){
    return div.apply(null, [{}].concat((function(){
      var i$, results$ = [];
      for (i$ in this.props.items) {
        results$.push((fn$.call(this, i$, this.props.items[i$])));
      }
      return results$;
      function fn$(k, v){
        return div({
          key: k
        }, h2({}, v.title), p({
          dangerouslySetInnerHTML: {
            __html: v.description
          }
        }, null), p({}, a({
          href: v.link
        }, 'More')));
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
    return this.bindAsArray(ref.limit(3), 'items');
  },
  render: function(){
    if (this.state.items.length === 0) {
      return div({}, 'Loading...');
    } else {
      return List({
        items: this.state.items[0]
      });
    }
  }
});
React.renderComponent(Blogroll(), document.getElementById('blogroll'));