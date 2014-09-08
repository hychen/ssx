require! express
require! nunjucks
require! path
require! morgan
favicon = require 'static-favicon'
i18n = require 'i18n-abide'

app = express!

# @FIXEME: a workround to add slash at the url end always if localOnUrl 
# is trigged.
app.use (req, res, next) ->
  if req.url is /zh-TW$/ or req.url is /en-US$/
    res.redirect "#{req.url}/" 
  next!

app.set 'views', path.join __dirname, 'views'
app.use favicon!
app.use morgan 'dev'
app.use express.static path.join __dirname, 'public'

app.use i18n.abide do
    supported_languages: [
      "en-US" , 
      "zh-TW"
    ],
    default_lang: "zh-TW",
    translation_directory: "locale",
    locale_on_url: true

app.set \port, process.env.PORT || 3000



nunjucks.configure (app.get \views), do
  autoescape: true
  express: app
<[index about partner contact accelerate alumni]>.map ->
   app.get "/#{it}.html", (req, res) -> 
    res.render "#{it}.html", {currentLocale: req.locale, currentPath: req.url}
app.get \/, (req, res) -> res.render "index.html", {currentLocale:req.locale, currentPath: req.url}

app.get \/sitemap.xml, (req, res) -> res.render "sitemap.xml"

server = app.listen app.get(\port), ->
  console.log 'Express server listening on port ' + server.address!port
