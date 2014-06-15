-- RedJSON Lib - Index
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
-- Functionality:
--   Create:
--     Args(2) - "create", "<field to index>"
--     Keys(0) - N/A
--     Take JSON field and create a sorted list of document keys
--
----------------------------------------

local command = ARGV[1]

local function notSystem(key)
   local substring = string.sub(key, 1, string.len("system") )
   return substring ~= "system"
end

local function getField(key, field)
  local val = redis.call('GET', key)
  local result = cjson.decode(cmsgpack.unpack(val))[field]

  return result
end

if command == "create" then
  -- create the index

  -- Get all keys
  local keys = redis.call('KEYS', '*')

  for _,key in ipairs(keys) do
    if notSystem(key) then
      -- System keys, don't do anything
      local val = getField(key, ARGV[2])
      redis.call('ZADD', "system:index:"..ARGV[2], val, key)
    end
  end

  return "created"
elseif command == "info" then
  -- get index info
  return redis.call('ZCARD', "system:index:"..ARGV[2])
elseif command == "update" then
  -- update the index
  return "updated"

elseif command == "query" then
  -- query index
  return redis.call('ZRANGEBYSCORE', "system:index:"..ARGV[2], ARGV[3],ARGV[4])
end
