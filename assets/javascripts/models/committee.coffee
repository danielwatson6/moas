class Moas.Models.Committee extends Backbone.Model
  
  urlRoot: '/committees'
  
  id: ->
    @get('_id')
