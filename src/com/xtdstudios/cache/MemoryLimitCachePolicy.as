package com.xtdstudios.cache
{
	

	public class MemoryLimitCachePolicy implements CachePolicy
	{
		private var m_maxMem			: uint;
		private var m_currentMem		: uint;

		private var m_memSize:ItemMemorySize;
		
		public function MemoryLimitCachePolicy(memSize: ItemMemorySize, maxMem : uint = uint.MAX_VALUE)
		{
			this.m_memSize = memSize;
			m_maxMem = maxMem;
			m_currentMem = 0;
		}

		public function get maxMem():uint
		{
			return m_maxMem;
		}
		
		public function get currentMem():uint
		{
			return m_currentMem;
		}
		
		
		public function beforeStore(m: CacheManager, key: Object, value: *): Boolean
		{
			if (!value) 
			{
				throw new Error("Cannot store null references"); 
			}
			var oldValue : * = m.fetch(key);
			if (oldValue == value)
				return false;
			var itemSize : uint = m_memSize.calcMemSize(value);
			var oldItemSize : uint = m_memSize.calcMemSize(oldValue);
			if (itemSize > m_maxMem)
				throw new Error("Item size exceed memory limit"); 
			m_currentMem += itemSize;
			while (m_currentMem-oldItemSize > m_maxMem)
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
			return value ? true : false 
		}
		
		public function afterRemove(cacheManager: CacheManager, key: Object, value: *): void
		{
			var itemSize : uint = m_memSize.calcMemSize(value);
			m_currentMem -= itemSize;
		}
	}
}