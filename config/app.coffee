express       = require 'express'
fs            = require 'fs'
favicon       = require 'static-favicon'
morgan        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
stylus        = require 'stylus'
connectAssets = require 'connect-assets'
mongoose      = require 'mongoose'
paths         = require './paths'
routes        = require './routes'
expressCoffee = require '../lib/express-coffee'
buildRouter   = require '../lib/build-router'


route = (app, name, options) ->
  controller = require "#{paths.controllers}/#{name}"
  if options.action? and not controller[options.action]?
    console.log "Error in router:"
    throw "No method '#{options.action}' found in controller '#{name}'"
  options.action = controller[options.action]
  app.use buildRouter(options)

buildModel = (controllerName) ->
  module = controllerName.split('-controller')[0]
  schema = new mongoose.Schema(
    require "#{paths.models}/#{module}"
  )
  modelKey = module.charAt(0).toUpperCase() + module.slice(1)
  mongoose.model(modelKey, schema)

# App setup
app = express()
app.use favicon()
app.use morgan('dev')
app.use bodyParser()
app.use cookieParser()
app.use express.static(paths.public)
app.set('views', paths.views)

# Jade setup for backend
app.set('view engine', 'jade')

# Coffeescript for backend
env = app.get('env')
app.use expressCoffee
  path:   paths.public
  live:   env isnt 'production'
  uglify: env is 'production'
  debug:  env isnt 'production'

# Front end assets
app.use connectAssets
  paths: [paths.javascripts, paths.stylesheets, paths.templates]

# Routes
for r of routes
  options = {}
  options.method = r.split(' ')[0].toLowerCase()
  options.path   = r.split(' ')[1]
  if options.method is 'resource'
    name = routes[r]
    if routes[r].split('#')[1] isnt undefined
      console.log "Error in router:"
      throw "Invalid RESTful route: '#{r}' => '#{routes[r]}'"
    options.model = buildModel(routes[r])
    # Blueprint methods
    controller = require "#{paths.controllers}/#{name}"
    options.actions =
      find:    controller.find
      findOne: controller.findOne
      create:  controller.create
      update:  controller.update
      destroy: controller.destroy
  else
    i = routes[r].split('#')
    name = i[0]
    if not i[1]? or i[1] is ''
      console.log "Error in router:"
      throw "No method specified for controller #{i[0]}"
    options.action = i[1]
  route(app, name, options)

module.exports = app
