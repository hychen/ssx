require! express
require! nunjucks
require! path
require! morgan
favicon = require 'static-favicon'
i18n = require 'i18n-abide'

app = express!
app.set 'views', path.join __dirname, 'views'
app.use favicon!
app.use morgan 'dev'
app.use express.static path.join __dirname, 'public'
app.use i18n.abide do
    supported_languages: [
      "en-US" , 
      "zh-TW"
    ],
    default_lang: "en-US",
    translation_directory: "locale",
    locale_on_url: true

app.set \port, process.env.PORT || 3000

nunjucks.configure (app.get \views), do
  autoescape: true
  express: app

<[index about partner contact accelerate alumni]>.map ->
   app.get "/#{it}.html", (req, res) -> res.render "#{it}.html"
app.get \/, (req, res) -> res.render "index.html"

server = app.listen app.get(\port), ->
  console.log 'Express server listening on port ' + server.address!port