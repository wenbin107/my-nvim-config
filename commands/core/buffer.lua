local M = {};
function M.get_mark(mark)
  local position = vim.api.nvim_buf_get_mark(0, mark)
    if position[1] == 0 then
        return nil
    end
    return { position[1], position[2] + 1}
end
M.get_line = function(line_num)
    return M.get_lines(line_num, line_num)[1]
end
M.get_lines = function(start, stop)
    return vim.api.nvim_buf_get_lines(0, start - 1, stop, false)
end
M.get_text = function(selection)
    local first_pos, last_pos = selection.first_pos, selection.last_pos
    last_pos[2] = math.min(last_pos[2], #M.get_line(last_pos[1]))
    return vim.api.nvim_buf_get_text(0, first_pos[1] - 1, first_pos[2] - 1, last_pos[1] - 1, last_pos[2], {})
end
-- Adds some text into the buffer at a given position.
---@param pos position The position to be inserted at.
---@param text text The text to be added.
M.insert_text = function(pos, text)
    pos[2] = math.min(pos[2], #M.get_line(pos[1]) + 1)
    vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2] - 1, text)
end

-- Replaces a given selection with a set of lines.
---@param selection selection|nil The given selection.
---@param text text The given text to replace the selection.
M.change_selection = function(selection, text)
    if not selection then
        return
    end
    local first_pos, last_pos = selection.first_pos, selection.last_pos
    vim.api.nvim_buf_set_text(0, first_pos[1] - 1, first_pos[2] - 1, last_pos[1] - 1, last_pos[2], text)
end

return M;
