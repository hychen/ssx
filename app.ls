require! express
require! nunjucks
require! path
require! morgan
require! 'google-spreadsheets'
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
app.use express.static path.join __dirname, 'frontend/public'

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

<[index about partner contact accelerate events alumni apply]>.map ->
   app.get "/#{it}.html", (req, res) -> 
    res.render "#{it}.html", {ENV: process.env.NODE_ENV, currentLocale: req.locale, currentPath: req.url}
app.get \/, (req, res) -> res.render "index.html", {ENV: process.env.NODE_ENV, currentLocale:req.locale, currentPath: req.url}

app.get '/events.json', (req, res) ->
  GoogleSpreadsheet = google-spreadsheets
  err, rows <- GoogleSpreadsheet.rows do 
    key: '1uQsCyyNK3VVdSgTI_tEywA9OhuQdL1BW6RQ2tBjt9wY'
    worksheet: 1
  if err
    console.error
    res.json []
  else
    events = [] 
    for row in rows
      events.push do 
        title: row.title
        url: row.url
        start: typeof row.start is \string and row.start or null
        end: typeof row.end is \string and row.end or null
    res.json events 

app.get \/sitemap.xml, (req, res) -> res.render "sitemap.xml"

server = app.listen app.get(\port), ->
  console.log 'Express server listening on port ' + server.address!port
