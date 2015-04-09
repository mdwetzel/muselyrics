# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.upvote').on "ajax:success", (e, data, status, xhr) ->
    set_score @, data.score
    set_voted_color @, data.type, data.remove
  $('.downvote').on "ajax:success", (e, data, status, xhr) ->
    set_score @, data.score
    set_voted_color @, data.type, data.remove

  set_score = (thisObj, score) -> 
    $(thisObj).siblings('span').text(score)

  set_voted_color = (thisObj, type, remove) ->
    if type == "upvote"
      $(thisObj).siblings('a').find('i').removeClass('voted')
      if remove
        $(thisObj).find('i').removeClass('voted')
      else
        $(thisObj).find('i').addClass('voted')
    else if type == "downvote"
      $(thisObj).siblings('a').find('i').removeClass('voted')
      if remove
        $(thisObj).find('i').removeClass('voted')
      else
        $(thisObj).find('i').addClass('voted')


