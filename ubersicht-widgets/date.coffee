command: "date +\"%a %d %b\""

refreshFrequency: 10000

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #B16286
  font: 17px Tamsyn8x17
  right: 65px
  top: 5px
"""
