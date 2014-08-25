#= require vendor/jquery.min
#= require vendor/bootstrap.min
#= require vendor/underscore.min
#= require vendor/backbone.min
#
#= require ./namespace
#
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#
#= require_tree .

$ ->
  # Start router with bootstrapped committees
  new Moas.Router Moas.committees
