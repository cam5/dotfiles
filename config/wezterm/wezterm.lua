local wezterm = require 'wezterm';

return {
  hide_tab_bar_if_only_one_tab = true,

  font = wezterm.font_with_fallback({
    {family="JetBrains Mono", weight="Medium"},
    "Pragmata Pro Mono",
  }),

  font_size = 15,

  line_height = 1.15,

  colors = {
    foreground = '#e4e4e4',
    background = '#1c1c1c',
    ansi = {
      '#1c1c1c',
      '#af5f00',
      '#5f8700',
      '#dfaf5f',
      '#5f8787',
      '#d75f5f',
      '#87afaf',
      '#e4e4e4',
    },
    brights = {
      '#262626',
      '#dfaf5f',
      '#87af87',
      '#ffff87',
      '#87afd7',
      '#e6bc72',
      '#87afaf',
      '#ffffff',
    }
  }
}
