-- RedJSON Lib - Set
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

-- Check if there are indexes on any of the fields
local val = cjson.decode(ARGV[1])

local indexes = redis.call('smembers','system:indexes')
for _, v in pairs(indexes) do
  if val[v] ~= nil then
    -- Update Index
    redis.call('ZADD', "system:index:"..v, val[v], KEYS[1])
  end
end

-- Return saved doc
return redis.call('set', KEYS[1], cmsgpack.pack(val))
