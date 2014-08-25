class Moas.Views.CommitteeIndex extends Backbone.View
  
  tagName: 'table'
  
  template: JST['committees/index']
  
  initialize: (options) ->
    @committees = options.collection
    @childTemplate = options.childTemplate
  
  appendCommittee: (committee) ->
    view = new Moas.Views.Committee
      model: committee
      template: @childTemplate
    @$el.append view.render().el
  
  render: ->
    @$el.html @template()
    @committees.each @appendCommittee, @
    @
