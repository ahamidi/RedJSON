-- RedJSON Lib - Create Index
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
-- Functionality:
-- Take JSON field and create a sorted list of document keys
--
----------------------------------------
local command = ARGV[1]

if command == "create" then
  -- create the index
  return redis.call('ZADD', KEYS[1], '1', 'one', '2', 'two')
elseif command == "info" then
  -- get index info
  return redis.call('ZCARD', KEYS[1])
elseif command == "update" then
  -- update the index
  return "updated"
end
