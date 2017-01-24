command: "~/.bin/spaces"

refreshFrequency: 500 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #D6E7EE
  font: 17px Tamsyn8x17
  line-height: 17px
  height: 17px
  left: 10px
  overflow: hidden
  text-overflow: ellipsis
  top: 5px
  width: 33%;
"""
