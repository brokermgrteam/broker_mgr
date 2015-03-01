
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


# This adds placeholder support to browsers that wouldn't otherwise support it. 
$.extend $.fn,
  mask: (content) ->
    a = @[0]
    if !a
      return console.log('mask', 'the cDom object is empty')
      this

    @unmask()
    b = {}
    b.cssText = a.style.cssText
    b.nextSibling = a.nextSibling
    b.parentNode = a.parentNode
    a.style.position = 'absolute'
    a.style.display = 'block'
    #        var _ina = document.createElement("container");  
    #        _ina.style.cssText = "position:absolute;top:0;left:0;width:0;height:0;z-index:100;";  
    #        var _inb = document.body;  
    #        _inb || document.write('<span id="__body__" style="display:none;">cQuery</span>');  
    #        ((_inb = document.body.firstChild) ? document.body.insertBefore(_ina, _inb) : document.body.appendChild(_ina));  
    #        (_inb = document.getElementById("__body__")) && _inb.parentNode.removeChild(_inb);  
    #        var _container = $(_ina);  
    #        _container.append(a);  
    a.style.left = (document.documentElement.scrollLeft or document.body.scrollLeft or 0) + Math.max(0, (document.documentElement.clientWidth - a.offsetWidth) / 2) + 'px'
    a.style.top = (document.documentElement.scrollTop or document.body.scrollTop or 0) + Math.max(0, (document.documentElement.clientHeight - a.offsetHeight) / 2) + 'px'
    c = 'background:#fff;position:absolute;left:0;top:0;width:' + Math.max(document.documentElement.clientWidth, document.documentElement.scrollWidth, document.body.clientWidth, document.body.scrollWidth) + 'px;height:' + Math.max(document.documentElement.clientHeight, document.documentElement.scrollHeight, document.body.clientHeight, document.body.scrollHeight) + 'px;'
    b.maskDiv = document.createElement('div')
    b.maskDiv.style.cssText = c + 'filter:progid:DXImageTransform.Microsoft.Alpha(opacity=50);opacity:0.5;'
    $(b.maskDiv).insertBefore a
    isIE = /msie/.test(navigator.userAgent.toLowerCase())
    isIE and b.maskIframe = document.createElement('iframe')
    b.maskIframe.style.cssText = c + 'filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);opacity:0;'
    $(b.maskIframe).insertBefore(b.maskDiv)
    @data '__mask__', b
    this
  unmask: ->
    if !@[0]
      return console.log('mask', 'the cDom object is empty')
      this

    a = @data('__mask__')
    a and @[0].style.cssText = a.cssText
    if a.nextSibling then @first().insertBefore(a.nextSibling) else @first().appendTo(a.parentNode)
    $(a.maskDiv).remove()
    a.maskIframe and $(a.maskIframe).remove()
    @removeData('__mask__')
    return
  placeholder: ->
    if 'placeholder' in document.createElement('input')
      this
      #如果原生支持placeholder属性，则返回对象本身  
    else
      @each ->
        _this = $(this)
        _this.focus(->
          if _this.val() == _this.attr('placeholder')
            _this.css 'color', ''
            _this.val ''
          return
        ).blur ->
          if _this.val().length == 0
            _this.val _this.attr('placeholder')
            _this.css 'color', 'gray'
          return
        if !_this.val()
          _this.val _this.attr('placeholder')
          _this.css 'color', 'gray'
        return

