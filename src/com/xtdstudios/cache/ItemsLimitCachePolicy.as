package com.xtdstudios.cache
{
	public class ItemsLimitCachePolicy implements CachePolicy
	{
		private var m_maxItems			: uint;
		
		public function ItemsLimitCachePolicy(maxItems : uint = uint.MAX_VALUE)
		{
			m_maxItems = maxItems;
		}
		
		public function get maxItems():uint
		{
			return m_maxItems;
		}
		
		
		public function beforeStore(m: CacheManager, key: Object, value: *): Boolean
		{
			if (m.fetch(key) == value)
				return false;
			if (m.length >= m_maxItems)
			{
				m.removeOldest();
			}
			return true;
		}
		
		public function afterStore(cacheManager: CacheManager, key: Object, value: *, oldValue : *): void
		{
			
		}
		
		public function beforeRemove(cacheManager: CacheManager, key: Object, value: *): Boolean
		{
			return true;
		}
		
		public function afterRemove(cacheManager: CacheManager, key: Object, value: *): void
		{
			
		}
	}
}