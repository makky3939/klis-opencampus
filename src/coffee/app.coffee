'use strict'

# GoogleAnalytics Tracking code
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