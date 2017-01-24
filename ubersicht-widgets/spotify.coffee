command: "echo $(~/.bin/sp)"

refreshFrequency: 1000 # ms

render: (output) ->
  "#{output}"

style: """
  color: rgba(255, 255, 255, 0.6)
  font: 14px Tamsyn7x14
  line-height: 20px;
  height: 20px;
  overflow: hidden
  text-overflow: ellipsis
  text-align: center;
  bottom: -4px
  left: 0px
  width: 100%;
  margin: 0 auto;
  text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);
"""
