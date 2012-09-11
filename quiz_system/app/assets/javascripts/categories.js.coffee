# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ =>
  $("#categories_list th a, #categories_list .pagination a").live "click", (e) =>
    link = $(e.target).attr 'href'
    $.getScript link
    return false
  $("#categories_search input").keyup =>
    $.get($("#categories_search").attr("action"), $("#categories_search").serialize(), null, "script")
    return false