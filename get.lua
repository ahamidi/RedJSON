-- RedJSON Lib - Get
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------
return cmsgpack.unpack(redis.call('get',KEYS[1]))
