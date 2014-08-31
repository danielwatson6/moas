#= require vendor/jquery.min
#= require vendor/bootstrap.min
#= require vendor/underscore.min
#= require vendor/backbone.min
#
#= require ./namespace
#
#= require_tree ../templates
#= require_tree ./views
#
#= require_tree .

$ ->
  new Moas.Router
  Backbone.history.start()
