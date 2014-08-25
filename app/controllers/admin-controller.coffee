module.exports =
  
  get: (req, res) ->
    res.render 'admin'
  
  post: (req, res) ->
    res.json req:req, res:res
  