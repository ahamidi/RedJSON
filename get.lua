-- RedJSON Lib - Get
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

-- TODO:
-- - Deal with index updating
return cjson.encode(cmsgpack.unpack(redis.call('get',KEYS[1])))
