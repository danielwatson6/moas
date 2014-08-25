module.exports =
  
  get: (req, res) ->
    Committees = require('mongoose').model 'Committee'
    Committees.find (err, committees) ->
      if err then res.send err
      res.render 'layout', committees: JSON.stringify(committees)
