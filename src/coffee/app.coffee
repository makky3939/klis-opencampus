'use strict'

# GoogleAnalytics Tracking code
->
  ((i, s, o, g, r, a, m) ->
    i['GoogleAnalyticsObject'] = r
    i[r] = i[r] or ->
      (i[r].q = i[r].q or []).push arguments
      return

    i[r].l = 1 * new Date()
    a = s.createElement(o)
    m = s.getElementsByTagName(o)[0]
    a.async = 1
    a.src = g
    m.parentNode.insertBefore a, m
  ) window, document, 'script', 'http://www.google-analytics.com/analytics.js', 'ga'
  ga 'create', 'UA-47328611-2', 'tsukuba.ac.jp'
  ga 'send', 'pageview'
  return this

$ ->
  $(window).scroll ->
    if $(this).scrollTop() > 400
      unless $('.js-scroll_to_top').css('display') == 'none'
        $('.js-scroll_to_top').fadeOut(600)
    else
      unless $('.js-scroll_to_top').css('display') == 'block'
        $('.js-scroll_to_top').fadeIn(600)
    return this

  $('.js-scroll_to_top').on 'click', ->
    $('html, body').animate({scrollTop : 0}, 400)
    return this
  return this