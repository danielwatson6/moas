module.exports =
  
  find: (req, res, committees) ->
    res.json committees
  
  findOne: (req, res, committee) ->
    res.json committee
  
  create: (req, res, committee) ->
    res.json _id: committee.get '_id'
  
  update: (req, res, committee) ->
    res.json committee
