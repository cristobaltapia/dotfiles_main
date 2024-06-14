require("tapia.remap")
require("tapia.set")
require("tapia.autocmd")

vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Define format for quickfix window
function _G.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = vim.fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fname_fmt1, fname_fmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local valid_fmt = "%s │%5d:%2d│%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = vim.fn.bufname(e.bufnr)
        if fname == "" then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local cnum = e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      local module
      if string.len(e.module) > 1 and string.len(e.text) > 1 then
        module = e.module .. ": "
      else
        module = e.module
      end
      local textm = e.text:gsub("\n", " ")
      str = valid_fmt:format(fname, lnum, cnum, qtype, module .. textm)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end
