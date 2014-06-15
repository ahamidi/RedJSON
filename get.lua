-- RedJSON Lib - Get
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------

return cjson.encode(cmsgpack.unpack(redis.call('get',KEYS[1])))
