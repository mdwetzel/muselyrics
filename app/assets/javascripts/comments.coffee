# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.upvote').on "ajax:success", (e, data, status, xhr) ->
    set_score @, data.score
  $('.downvote').on "ajax:success", (e, data, status, xhr) ->
    set_score @, data.score

  set_score = (thisObj, score) -> 
    $(thisObj).siblings('span').text(score)
