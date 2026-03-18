
function is_image(path)
  local ext = path:match("^.+%.([^/]+)$")  -- grab file extension
  if not ext then
    return false
  end
  ext = ext:lower()
  local exts = {
    png = true,
    jpg = true,
    jpeg = true,
    gif = true,
    bmp = true,
    webp = true,
    tiff = true,
    svg = true, -- if you want
  }
  return exts[ext] or false
end

local function get_preview_window_geometry()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_get_option_value("previewwindow", { win = win }) then
      local pos = vim.api.nvim_win_get_position(win)
      local w = vim.api.nvim_win_get_width(win)
      local h = vim.api.nvim_win_get_height(win)
      return {
        winid = win,
        x = pos[2],
        y = pos[1],
        width = w,
        height = h,
      }
    end
  end
  return nil -- no preview window open
end

local timer
local image
vim.api.nvim_create_autocmd({ "CursorMoved", "ModeChanged" }, {
  desc = "Oil image preview",
  callback = function()
    if timer then
      timer:again()
      return
    end
    timer = vim.loop.new_timer()
    if not timer then
      return
    end
    timer:start(200, 200, function()
      timer:stop()
      timer:close()
      timer = nil

      vim.schedule(function()
        if image then
          image:clear()
          image = nil
        end

        -- and updating the preview in visual mode can cause flicker and stutter
        local mode = vim.api.nvim_get_mode().mode
        local is_visual_mode = mode:match("^[vV]") ~= nil
        if is_visual_mode then
          return
        end

        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        local preview_window = get_preview_window_geometry()
        if entry and preview_window then
          local full_path = oil.get_current_dir() .. entry.name
          if is_image(full_path) then
            local api = require("image")
            image = api.from_file(full_path, {
              x = preview_window.x,
              y = preview_window.y,
              width = preview_window.width,
              height = preview_window.height
            })
            image:render()
          end
        end
      end)
    end)
  end,
})

local M = {}
M.is_image = is_image
return M

