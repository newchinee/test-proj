# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ =>
  $("#admin_users_list th a, #admin_users_list .pagination a").live "click", (e) =>
    link = $(e.target).attr 'href'
    $.getScript link
    return false
  $("#admin_users_search input").keyup =>
    $.get($("#admin_users_search").attr("action"), $("#admin_users_search").serialize(), null, "script")
    return false