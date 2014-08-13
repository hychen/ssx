require! express
require! path
require! morgan
favicon = require 'static-favicon'

app = express!
app.set 'views', path.join __dirname, 'views'
app.use favicon!
app.use morgan 'dev'
app.use express.static path.join __dirname, 'public'

app.set \port, process.env.PORT || 3000
app.set('view engine', 'jade')
app.engine('jade', require('jade').__express);

<[index about partner contact accelerate]>.map ->
  app.get "/#{it}", (req, res) -> res.render "#{it}", {}
app.get '/', (req, res) -> res.render 'index', {}

server = app.listen app.get(\port), ->
  console.log 'Express server listening on port ' + server.address!port