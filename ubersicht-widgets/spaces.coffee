command: "~/.bin/spaces"

refreshFrequency: 500 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #555
  font: 9px Tamsyn5x9
  line-height: 9px
  height: 9px
  left: 5px
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 100%
  text-align: center
"""
