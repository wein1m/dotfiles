-- AGHH I CHANGE TO CASCADIA FONT JUST FOR THIS.. AND NOW I NEED TO RECONFIGURE MY WHOLE SETUP CUZ THIS FONT JUST DIFFERENT IN A WHOLE LEVEL COMPARED TO MY PREV FONT (GEIST MONO) 
return {
  "sphamba/smear-cursor.nvim",
  lazy = false,
  opts = {                                -- Default  Range
    stiffness = 0.7,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.5,             -- 0.45     [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.5      [0, 1]
    damping = 0.95,                       -- 0.85     [0, 1]
    damping_insert_mode = 0.95,           -- 0.9      [0, 1]
    distance_stop_animating = 0.1,        -- 0.1      > 0
    never_draw_over_target = true,
    hide_target_hack = true,
    cterm_cursor_colors = { 181, 218, 255, 255 },
    cursor_color = "#b5daff",
    smear_replace_mode = true,
    horizontal_bar_cursor_replace_mode = false,
    smear_terminal_mode = true,
    legacy_computing_symbols_support = true,
    particle = true,
  },
}
