mongoose = require 'mongoose'

DB_NAME = 'foo'

module.exports = ->
  
  # Mongoose setup
  mongoose.connect("mongodb://localhost/#{DB_NAME}")
  db = mongoose.connection
  db.on('error', console.error.bind(console, 'connection error:'))
  
  return
