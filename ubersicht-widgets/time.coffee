command: "date +\"%H:%M\""

refreshFrequency: 10000 # ms

render: (output) ->
  "#{output}"

style: """
  color: #458588
  font: 17px Tamsyn8x17
  right: 15px
  text-align: left;
  top: 5px
"""
