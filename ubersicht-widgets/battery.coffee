command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"

refreshFrequency: 150000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  font: 17px Tamsyn8x17
  top: 5px
  right: 155px
  color: #FABD2F
  span
    color: #9C9486
"""
