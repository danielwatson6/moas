express       = require 'express'
favicon       = require 'serve-favicon'
morgan        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
stylus        = require 'stylus'
connectAssets = require 'connect-assets'
paths         = require './paths'
routes        = require './routes'
expressCoffee = require '../lib/express-coffee'

# App setup
app = express()

#app.use favicon()
app.use morgan 'dev'
app.use bodyParser()
app.use cookieParser()
app.use express.static(paths.public)

app.set 'views', paths.views
app.set 'view engine', 'jade'

env = app.get 'env'
app.use expressCoffee
  path:   paths.public
  live:   env isnt 'production'
  uglify: env is   'production'
  debug:  env isnt 'production'

# Front end assets
app.use connectAssets
  paths: [paths.javascripts, paths.stylesheets, paths.templates]

# Grab routes in config/routes.coffee
for r of routes
  options =
    method: r.split(' ')[0].toLowerCase()
    path:   r.split(' ')[1]
  i = routes[r].split '#'
  name = i[0]
  if not i[1]? or i[1] is ''
    console.log "Error in router:"
    throw "No method specified for controller '#{i[0]}'"
  options.action = i[1]
  controller = require "#{paths.controllers}/#{name}"
  if options.action? and not controller[options.action]?
    console.log "Error in router:"
    throw "No method '#{options.action}' found in controller '#{name}'"
  options.action = controller[options.action]
  router = express.Router()
  router.route(options.path)[options.method] options.action
  app.use router

module.exports = app
