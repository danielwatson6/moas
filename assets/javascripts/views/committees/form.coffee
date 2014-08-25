class Moas.Views.CommitteeForm extends Backbone.View
  
  template: JST['committees/form']
  
  initialize: (committees) ->
    @committees = committees
  
  events:
    'click #save': 'saveCommittee'
  
  saveCommittee: ->
    committeeData = {}
    fields = [
      'name', 'topic', 'chairs'
      'chair1_name', 'chair1_email', 'chair1_url'
      'chair2_name', 'chair2_email', 'chair2_url'
    ]
    # Get all fields
    for f in fields
      # Get user input on the current field
      committeeData[f] = @$el.find("##{f}").val()
      # Stop if one of the fields is empty
      return if !committeeData[f]
    # Create model
    callback = (model) =>
      # Router listens for this event
      @trigger 'committeeSaved', model.id()
    @committees.create committeeData, success: 
  
  render: ->
    @$el.html @template()
    @
