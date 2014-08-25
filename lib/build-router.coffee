express = require 'express'

properties = (model) ->
  result = []
  keylist = Object.keys(model.schema.paths)
  for k in keylist
    if k.indexOf('_') isnt 0 then result.push(k)
  result
  
# Create a router object and return it
module.exports = (options) ->
  router = express.Router()
  # Build Rest API if specified
  if options.method is 'resource'
    model = options.model
    router.route(options.path)
      .get( (req, res) =>
        model.find (err, models) ->
          if err then res.send(err)
          (options.actions.find || (req,res,models) ->)(req,res,models)
      )
      .post( (req, res) =>
        props = properties(model)
        e = new model
        for p in props
          e[p] = req.body[p]
        e.save (err, model) ->
          if err then res.send(err)
          (options.actions.create || (req,res,model) ->)(req,res,model)
      )
    router.route(options.path + '/:id')
      .get( (req, res) =>
        model.findById (err, model) ->
          if err then res.send(err)
          res.json(model)
          (options.actions.findOne || (req,res,model) ->)(req,res,model)
      )
      .put( (req, res) =>
        model.findById req.params.id, (err, e) =>
          if err then res.send(err)
          props = properties(model)
          for p in props
            e[p] = req.body[p]
          e.save (err, model) ->
            if err then res.send(err)
            res.json(model)
            (options.actions.update || (req,res,model) ->)(req,res,model)
      )
      .delete( (req, res) =>
        model.remove _id: req.params.id, (err) ->
          if err then res.send(err)
          (options.actions.destroy || (req,res) ->)(req,res)
      )
  else
    router.route(options.path)[options.method](options.action)
  router
