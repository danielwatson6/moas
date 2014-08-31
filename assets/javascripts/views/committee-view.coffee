class Moas.CommitteeView extends Backbone.View
  
  template: JST['committee']
  
  className: 'row'
  
  initialize: (options) ->
    @name = options.name
    @data = Moas.Committees[@name]
  
  events:
    'click #topic'  : 'selectTopic'
    'click #chairs' : 'selectChairs'
  
  removeActives: ->
    @$el.find('.nav-pills li').removeClass 'active'
    @$el.find('.committee-content').hide()
  
  selectTopic: ->
    @removeActives()
    @$el.find('#topic').addClass 'active'
    @$el.find('#topic-content').show()
  
  selectChairs: ->
    @removeActives()
    @$el.find('#chairs').addClass 'active'
    @$el.find('#chairs-content').show()
  
  render: ->
    @$el.html @template
      committee: @data
    @selectTopic()
    @
