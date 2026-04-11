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

-- Parse clickhouse client config.xml for a named connection or top-level defaults.
-- Returns table with hostname, port, user, password, database (any may be nil).
local function parse_ch_config(connection_name)
  local path = vim.env.HOME .. "/.clickhouse-client/config.xml"
  local f = io.open(path, "r")
  if not f then return nil end
  local xml = f:read("*a")
  f:close()

  -- Helper: extract tag value from XML string
  local function tag(str, name)
    return str:match("<" .. name .. ">(.-)</" .. name .. ">")
  end

  -- If connection_name given, find that <connection> block
  if connection_name then
    for block in xml:gmatch("<connection>(.-)</connection>") do
      if tag(block, "name") == connection_name then
        return {
          hostname = tag(block, "hostname") or tag(block, "host"),
          port = tag(block, "port"),
          user = tag(block, "user"),
          password = tag(block, "password"),
          database = tag(block, "database"),
          secure = tag(block, "secure"),
        }
      end
    end
  end

  -- Fall back to top-level settings (outside <connections_credentials>)
  -- Strip the connections_credentials block first to avoid matching nested tags
  local top = xml:gsub("<connections_credentials>.-</connections_credentials>", "")
  return {
    hostname = tag(top, "hostname") or tag(top, "host"),
    port = tag(top, "port"),
    user = tag(top, "user"),
    password = tag(top, "password"),
    database = tag(top, "database"),
    secure = tag(top, "secure"),
  }
end

-- Grep ps output for a process matching pattern on the same tty
local function find_process_cmd(pattern)
  local h = io.popen("ps 2>/dev/null")
  if not h then return nil end
  local output = h:read("*a")
  h:close()
  for line in output:gmatch("[^\n]+") do
    if line:match(pattern) and not line:match("grep") and not line:match("nvim") then
      return line:match("%d+:%S+%s+(.+)$")
    end
  end
  return nil
end

-- Find psql in process list by PID embedded in temp file name
local function find_psql_cmd()
  local psql_pid = vim.fn.expand("%:t"):match("psql%.edit%.(%d+)")
  if not psql_pid then return nil end

  local h = io.popen("ps 2>/dev/null")
  if not h then return nil end
  local output = h:read("*a")
  h:close()
  for line in output:gmatch("[^\n]+") do
    if line:match("^%s*" .. psql_pid .. "%s") and line:match("psql") then
      return line:match("psql.*$")
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

-- Build clickhouse dadbod URL (dadbod uses native protocol via clickhouse-client)
local function build_ch_url(host, port, user, password, dbname, secure)
  host = host or "localhost"
  port = port or "9000"
  user = user or "default"
  dbname = dbname or "default"
  local auth = password and (user .. ":" .. password) or user
  local url = string.format("clickhouse://%s@%s:%s/%s", auth, host, port, dbname)
  if secure == "1" or secure == "true" then
    url = url .. "?secure=1"
  end
  return url
end

-- Auto-detect dadbod connection when opened from psql (\e) or clickhouse (opt+e).
if not vim.b.db or vim.b.db == "" then

  -- Try psql
  local psql_cmd = find_psql_cmd()
  if psql_cmd then
    local url = psql_cmd:match("postgresql://[^%s]+") or psql_cmd:match("postgres://[^%s]+")
    if url then
      vim.b.db = url
    else
      local service = psql_cmd:match("service=(%S+)")
      if service then
        local svc = parse_pg_service(service)
        if svc then
          vim.b.db = build_pg_url(svc.host, svc.port, svc.user, svc.dbname, svc.password)
        end
      else
        local host = psql_cmd:match("%-h%s+(%S+)") or psql_cmd:match("%-%-host[= ](%S+)")
        local port = psql_cmd:match("%-p%s+(%d+)") or psql_cmd:match("%-%-port[= ](%d+)")
        local user = psql_cmd:match("%-U%s+(%S+)") or psql_cmd:match("%-%-username[= ](%S+)")
        local dbname = psql_cmd:match("%-d%s+(%S+)") or psql_cmd:match("%-%-dbname[= ](%S+)")
        if not dbname then
          dbname = psql_cmd:match("%s([%w_%-]+)%s*$")
          if dbname and dbname:match("^%-") then dbname = nil end
        end
        vim.b.db = build_pg_url(
          host or vim.env.PGHOST, port or vim.env.PGPORT,
          user or vim.env.PGUSER, dbname or vim.env.PGDATABASE
        )
      end
    end
  end

  -- Try clickhouse
  if not vim.b.db or vim.b.db == "" then
    local is_ch_file = vim.fn.expand("%:t"):match("^clickhouse_client_editor_")
    if is_ch_file then
      -- Try to get --connection name from ps (may be visible if before --password)
      local ch_cmd = find_process_cmd("clickhouse client")
      local connection_name = ch_cmd and ch_cmd:match("%-%-connection%s+(%S+)")

      -- Parse config.xml for connection details (named or top-level defaults)
      local ch = parse_ch_config(connection_name)
      if ch and ch.hostname then
        vim.b.db = build_ch_url(ch.hostname, ch.port, ch.user, ch.password, ch.database, ch.secure)
      end
    end
  end
end
