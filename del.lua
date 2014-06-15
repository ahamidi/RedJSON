-- RedJSON Lib - Delete
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

-- TODO:
-- - Deal with index updating
return redis.call('del', KEYS[1])
