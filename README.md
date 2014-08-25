Express with CoffeeScript
=========================

This setup includes a setup for using coffeescript in express.js in the backend.

## Features

### MVC

In the `app` directory, you can find subfolders for models, views, and controllers

Models use mongoose. Example model:
    
    mongoose = require 'mongoose'

    ZombieSchema = new mongoose.Schema
      name: String
      age: Number
      graveyard: String

    module.exports = mongoose.model('Zombie', ZombieSchema)

### Built-in REST API

The `Controller` class in the `lib` folder includes CRUD operations and a `router` method. Example controller:
    
    # app/controllers/zombie-controller.coffee
    
    Controller = require '../../lib/controller'
    Zombie     = require '../models/zombie'

    class ZombieController extends Controller
      urlRoot: '/zombies'
      model: Zombie

    module.exports = ZombieController

To use a controller in the app and route accordingly, set `urlRoot` property in controller and add the controller to the app file:
    
    zombieController = new ZombieController
    app.use zombieController.router(rest: true)

## Dependencies

This project requires CoffeeScript and MongoDB installed locally.
By default, templates are using jade, and stylesheets are using stylus.

### Running Mongo

Once you have MongoDB installed, assuming you have mongo scripts in your $PATH, these commands can start the database:

    $ mkdir data
    $ mkdir data/db
    $ mongod --dbpath ./data

The mongo console can be used with `$ mongo`

## Using

To use this setup, run `git clone git://github.com/djwatt5/express-coffee.git`
Create directory for models: `$ mkdir app/models`
