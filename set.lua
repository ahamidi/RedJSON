-- RedJSON Lib - Set
--
-- Author: Ali Hamidi <ahamidi@me.com>
--
----------------------------------------
return redis.call('set', KEYS[1], cmsgpack.pack(ARGV[1]))
