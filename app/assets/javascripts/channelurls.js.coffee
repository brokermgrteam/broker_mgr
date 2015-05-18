# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  $(".branch_selection").on "change", ->
    $.ajax
      url: "/channelurls/get_brokers"
      type: "GET"
      dataType: "script"
      data:
        branch_id: $('.branch_selection option:selected').val()

  $(".channel_selection").on "change", ->
    $.ajax
      url: "/channelurls/get_subchannels"
      type: "GET"
      dataType: "script"
      data:
        channel_id: $('.channel_selection option:selected').val()

  
