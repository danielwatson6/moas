class Moas.Router extends Backbone.Router
  
  routes:
    ''                 : 'homeView'
    'committees/:name' : 'committeeView'
    'about'            : 'staticView'
    'hotel'            : 'staticView'
    'schedule'         : 'staticView'
    'dates'            : 'staticView'
    'preparation'      : 'staticView'
    'the-view'         : 'staticView'
    'gallery'          : 'staticView'
    'contact'          : 'staticView'
  
  homeView: ->
    @currentView = new Moas.StaticView
      template: JST['static/home']
    @setCurrentView @currentView
  
  committeeView: (name) ->
    @currentView = new Moas.CommitteeView
      name: name
    @setCurrentView @currentView
  
  staticView: ->
    # Create the template path based on URL hashtag
    name = window.location.hash.slice 1
    templatePath = 'static/' + name
    # Render passing the template path
    @currentView = new Moas.StaticView
      template: JST[templatePath]
    @setCurrentView @currentView
  
  setCurrentView: (view) ->
    # Override the page's content
    $('#app').html view.render().el
