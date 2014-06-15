-- RedJSON Lib - Index
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

local command = ARGV[1]

-- Helper to exclude system keys from processing
local function notSystem(key)
   local substring = string.sub(key, 1, string.len("system") )
   return substring ~= "system"
end

-- Helper to parse packed docs
local function getField(key, field)
  local val = redis.call('GET', key)
  local result = cmsgpack.unpack(val)[field]

  return result
end

-- Create Index
local function createIndex(field)
  -- Get all keys
  local keys = redis.call('KEYS', '*')

  for _,key in ipairs(keys) do
    if notSystem(key) then
      -- System keys, don't do anything
      local val = getField(key, field)
      redis.call('ZADD', "system:index:"..field, val, key)
    end
  end

  return "created"
end

-- Index Info
local function indexInfo(index)
  return redis.call('ZCARD', "system:index:"..index)
end

-- Update Index
local function updateIndex(index)
  return "updated"
end

-- Query Index
local function queryIndex(index, startKey, endKey)
  return redis.call('ZRANGEBYSCORE', "system:index:"..index, startKey, endKey)
end

-- MAIN
if command == "create" then
  return createIndex(ARGV[2])
elseif command == "info" then
  return indexInfo(ARGV[2])
elseif command == "update" then
  return updateIndex(ARGV[2])
elseif command == "query" then
  return queryIndex(ARGV[2], ARGV[3], ARGV[4])
end
