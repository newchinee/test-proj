# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ =>
  $("#results_list th a, #results_list .pagination a").live "click", (e) =>
    link = $(e.target).attr 'href'
    $.getScript link
    return false
  $("#results_search input").keyup =>
    $.get($("#results_search").attr("action"), $("#results_search").serialize(), null, "script")
    return false
  $("#results_search select").change =>
    $.get($("#results_search").attr("action"), $("#results_search").serialize(), null, "script")
    return false