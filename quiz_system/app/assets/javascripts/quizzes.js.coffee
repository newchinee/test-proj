# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ =>
  $("#quizzes_list th a, #quizzes_list .pagination a").live "click", (e) =>
    link = $(e.target).attr 'href'
    $.getScript link
    return false
  $("#quizzes_search input").keyup =>
    $.get($("#quizzes_search").attr("action"), $("#quizzes_search").serialize(), null, "script")
    return false