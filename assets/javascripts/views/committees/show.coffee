class Moas.Views.Committee extends Backbone.View
  
  initialize: (options) ->
    @committee = options.model
    @template  = options.template
  
  render: ->
    # TODO: remove calls to @committee inside template
    @$el.html @template
      committee: @committee
    @
