// Generated by LiveScript 1.2.0
(function(){
  var express, nunjucks, path, morgan, favicon, app, server;
  express = require('express');
  nunjucks = require('nunjucks');
  path = require('path');
  morgan = require('morgan');
  favicon = require('static-favicon');
  app = express();
  app.set('views', path.join(__dirname, 'views'));
  app.use(favicon());
  app.use(morgan('dev'));
  app.use(express['static'](path.join(__dirname, 'public')));
  app.set('port', process.env.PORT || 3000);
  nunjucks.configure(app.get('views'), {
    autoescape: true,
    express: app
  });
  ['index', 'about', 'partner', 'contact', 'accelerate'].map(function(it){
    return app.get("/" + it, function(req, res){
      return res.render(it + ".html");
    });
  });
  app.get('/', function(req, res){
    return res.render("index.html");
  });
  server = app.listen(app.get('port'), function(){
    return console.log('Express server listening on port ' + server.address().port);
  });
}).call(this);
