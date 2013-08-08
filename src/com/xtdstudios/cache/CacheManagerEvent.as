package com.xtdstudios.cache
{
	import flash.events.Event;
	
	public class CacheManagerEvent extends Event
	{
		public static const ITEM_ADDED	: String = "CACHE_MANAGER_ITEM_ADDED";
		public static const ITEM_REMOVED	: String = "CACHE_MANAGER_ITEM_REMOVED";
		
		private var m_key: Object;
		private var m_value: *;
		
		public function CacheManagerEvent(type:String, key: Object, value: * = null)
		{
			super(type, false, false);
			this.m_key = key;
			this.m_value = value;
		}
		
		public function get key():Object
		{
			return m_key;
		}

		public function get value():*
		{
			return m_value;
		}

		public override function clone():Event {
			return new CacheManagerEvent(type, m_key, m_value);
		}


	}
}