-- Deferred plugin setup helper.
-- Queues callbacks to run after VimEnter via vim.schedule() (FIFO order).
-- If called after VimEnter has already fired, schedules immediately.
local M = {}

local queue = {}

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    for _, fn in ipairs(queue) do
      vim.schedule(fn)
    end
    queue = nil
  end,
})

function M.on_vim_enter(fn)
  if queue then
    table.insert(queue, fn)
  else
    vim.schedule(fn)
  end
end

return M
