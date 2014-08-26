crary = require 'crary'

setupRouter = (router) ->
  router.get '/echo', (req, res) ->
    res.sendResult response: req.query.message

app = crary.express.createApp
  project_root: __dirname
  log4js_config:
    appenders: [ {
      type: 'console'
    } ]
    replaceConsole: false
  redis_port: 6379
  session_ttl: 300
  session_secret: 'crary'
  routers:
    '': setupRouter
require('http').createServer(app).listen 3000
