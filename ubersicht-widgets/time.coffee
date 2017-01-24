command: "date +\"%H:%M\""

refreshFrequency: 10000 # ms

render: (output) ->
  "#{output}"

style: """
  color: #5f8787
  font: 17px Tamsyn8x17
  right: 15px
  text-align: left;
  top: 5px
"""
