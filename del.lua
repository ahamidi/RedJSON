-- RedJSON Lib - Delete
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

-- Check if there are indexes on any of the fields
local val = cmsgpack.unpack(redis.call('get', KEYS[1]))

local indexes = redis.call('smembers','system:indexes')
for _, v in pairs(indexes) do
  if val[v] ~= nil then
    -- Update Index
    redis.call('ZREM', "system:index:"..v, KEYS[1])
  end
end

-- Delete Key
return redis.call('del', KEYS[1])
