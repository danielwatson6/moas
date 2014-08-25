class Moas.Router extends Backbone.Router
  
  initialize: (committees) ->
    @committees = committees
    Backbone.history.start()
  
  setCurrentView: (view) ->
    # Override the page's content
    $('#app').html view.render().el
  
  routes:
    ''                    : 'setStaticView'
    'committees'          : 'committeesIndex'
    'committees/new'      : 'committeesNew'
    'committees/:id'      : 'committeesShow'
    'committees/:id/edit' : 'committeesEdit'
    'about'               : 'setStaticView'
    'hotel'               : 'setStaticView'
    'schedule'            : 'setStaticView'
    'dates'               : 'setStaticView'
    'preparation'         : 'setStaticView'
    'the-view'            : 'setStaticView'
    'gallery'             : 'setStaticView'
    'contact'             : 'setStaticView'
  
  setStaticView: ->
    # Create the template path based on URL hashtag
    name = window.location.hash.slice 1
    templatePath = 'static/' + (name or 'home')
    # Render and pass the template path
    @currentView = new Moas.Views.StaticView
      template: JST[templatePath]
    @setCurrentView @currentView
  
  committeesIndex: ->
    # TODO: Only grant access to admin
    @currentView = new Moas.Views.CommitteeIndex
      collection: @committees
      childTemplate: JST['committees/row']
    @setCurrentView @currentView
  
  committeesNew: ->
    # TODO: Only grant access to admin
    @currentView = new Moas.Views.CommitteeForm @committees
    @setCurrentView @currentView
    @listenTo @currentView, 'committeeSaved', @showCommittee
  
  committeesShow: (id) ->
    @currentView = new Moas.Views.Committee
      model: @committees.get id
      template: JST['committees/show']
    @setCurrentView @currentView
  
  committeesEdit: (id) ->
    # TODO: Only grant access to admin
    # TODO: Make CommitteeForm view accept single committee
    @currentView = new Moas.Views.CommitteeForm @committees.get id
    @setCurrentView @currentView
    @listenTo @currentView, 'committeeSaved', @showCommittee
  
  # Methods
  
  showCommittee: (id) =>
    @navigate 'committees/' + id, trigger: true
