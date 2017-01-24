command: "echo $(/usr/local/bin/kwmc query window focused name | sed 's/🔊//')"

refreshFrequency: 1000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #D6E7EE
  /* font: 17px Tamsyn8x17 */
  font: 600 15px/28px Open Sans;
  text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);
  height: 30px
  line-neight: 20px;
  left: 33%
  text-align: center;
  overflow: hidden
  text-overflow: ellipsis
  width: 33%;
"""
