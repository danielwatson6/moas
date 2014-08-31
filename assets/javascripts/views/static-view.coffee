class Moas.StaticView extends Backbone.View
  
  initialize: (options) ->
    @template = options.template
  
  render: ->
    @$el.html @template()
    @
