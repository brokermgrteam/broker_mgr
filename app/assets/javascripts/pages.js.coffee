
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# jQuery ->
# 	$('#categories_category_name').autocomplete({
# 		# minLength: 2
# 		source: $('#categories_category_name').data('autocomplete-source')
# 		focus: (event, ui) ->
# 			$("#categories_category_name").val ui.item.broker_code + "-" + ui.item.broker_name
# 			false
# 		select: (event, ui) ->
# 			$("#categories_category_name").val ui.item.broker_code + "-" + ui.item.broker_name
# 			# $("#link_broker_id").val ui.item.id
# 			false
# 	 })	.data("autocomplete")._renderItem = (ul, item) ->
# 		    $("<li></li>").data("item.autocomplete", item).append("<a>" + item.broker_code + "-" + item.broker_name + "</a>").appendTo ul

jQuery ->
  jQuery.support.placeholder = false
  test = document.createElement("input")
  jQuery.support.placeholder = true  if "placeholder" of test
  return


# This adds placeholder support to browsers that wouldn't otherwise support it. 
$ ->
  unless $.support.placeholder
    active = document.activeElement
    $(":text").focus(->
      $(this).val("").removeClass "hasPlaceholder"  if $(this).attr("placeholder") isnt "" and $(this).val() is $(this).attr("placeholder")
      return
    ).blur ->
      $(this).val($(this).attr("placeholder")).addClass "hasPlaceholder"  if $(this).attr("placeholder") isnt "" and ($(this).val() is "" or $(this).val() is $(this).attr("placeholder"))
      return

    $(":text").blur()
    $(active).focus()
    $("form:eq(0)").submit ->
      $(":text.hasPlaceholder").val ""
      return

  return