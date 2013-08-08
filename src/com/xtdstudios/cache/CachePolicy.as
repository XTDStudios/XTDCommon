package com.xtdstudios.cache
{
	public interface CachePolicy
	{
		function beforeStore(cacheManager: CacheManager, key: Object, value: *): Boolean;
		function afterStore(cacheManager: CacheManager, key: Object, value: *, oldValue : *): void;
		function beforeRemove(cacheManager: CacheManager, key: Object, value: *): Boolean;
		function afterRemove(cacheManager: CacheManager, key: Object, value: *): void;
	}
}