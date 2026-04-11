vim.opt_local.shiftwidth = 4

-- Parse a service entry from ~/.pg_service.conf
local function parse_pg_service(service_name)
  local path = vim.env.PGSERVICEFILE or (vim.env.HOME .. "/.pg_service.conf")
  local f = io.open(path, "r")
  if not f then return nil end

  local in_section = false
  local result = {}
  for line in f:lines() do
    local section = line:match("^%[(.+)%]$")
    if section then
      if in_section then break end
      in_section = (section == service_name)
    elseif in_section then
      local key, val = line:match("^(%w+)%s*=%s*(.+)$")
      if key and val then
        result[key] = val:gsub("%s+$", "")
      end
    end
  end
  f:close()
  return in_section and result or nil
end

-- Find psql in the process list by matching the temp file PID.
-- psql temp files are named psql.edit.<PID>.sql where PID is the psql process.
-- Falls back to grepping for psql on the same tty.
local function find_psql_cmd()
  -- Try to extract psql PID from temp file name (psql.edit.<PID>.sql)
  local psql_pid = vim.fn.expand("%:t"):match("psql%.edit%.(%d+)")

  if psql_pid then
    local h = io.popen("ps -o command= -p " .. psql_pid .. " 2>/dev/null")
    if h then
      local cmd = h:read("*a"):gsub("^%s+", ""):gsub("%s+$", "")
      h:close()
      if cmd ~= "" then return cmd end
    end
    -- Per-PID query failed (macOS), grep full ps output
    local h2 = io.popen("ps 2>/dev/null")
    if h2 then
      local output = h2:read("*a")
      h2:close()
      for line in output:gmatch("[^\n]+") do
        if line:match("^%s*" .. psql_pid .. "%s") and line:match("psql") then
          return line:match("psql.*$")
        end
      end
    end
  end

  return nil
end

-- Build dadbod URL from connection details
local function build_pg_url(host, port, user, dbname, password)
  host = host or "localhost"
  port = port or "5432"
  user = user or vim.env.USER
  dbname = dbname or user
  if password then
    return string.format("postgresql://%s:%s@%s:%s/%s", user, password, host, port, dbname)
  end
  return string.format("postgresql://%s@%s:%s/%s", user, host, port, dbname)
end

-- Auto-detect dadbod connection when opened from psql (\e).
if not vim.b.db or vim.b.db == "" then
  local parent_cmd = find_psql_cmd()

  if parent_cmd then
    -- Check for postgresql:// URL in args
    local url = parent_cmd:match("postgresql://[^%s]+") or parent_cmd:match("postgres://[^%s]+")
    if url then
      vim.b.db = url
    else
      -- Check for service=NAME
      local service = parent_cmd:match("service=(%S+)")
      if service then
        local svc = parse_pg_service(service)
        if svc then
          vim.b.db = build_pg_url(svc.host, svc.port, svc.user, svc.dbname, svc.password)
        end
      else
        -- Parse explicit flags
        local host = parent_cmd:match("%-h%s+(%S+)") or parent_cmd:match("%-%-host[= ](%S+)")
        local port = parent_cmd:match("%-p%s+(%d+)") or parent_cmd:match("%-%-port[= ](%d+)")
        local user = parent_cmd:match("%-U%s+(%S+)") or parent_cmd:match("%-%-username[= ](%S+)")
        local dbname = parent_cmd:match("%-d%s+(%S+)") or parent_cmd:match("%-%-dbname[= ](%S+)")

        if not dbname then
          dbname = parent_cmd:match("%s([%w_%-]+)%s*$")
          if dbname and dbname:match("^%-") then dbname = nil end
        end

        vim.b.db = build_pg_url(
          host or vim.env.PGHOST,
          port or vim.env.PGPORT,
          user or vim.env.PGUSER,
          dbname or vim.env.PGDATABASE
        )
      end
    end
  end
end
