/*
Copyright 2012 XTD Studios Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package com.xtdstudios.collections
{
	import flash.display.DisplayObject;

	public class VectorIterator extends ProxyIterator
	{
		private var m_displayObjects:Vector.<Object>;
		private var m_map : Function;
		
		public function VectorIterator(displayObjects:Vector.<Object>, map: Function = null)
		{
			super();
			m_displayObjects = displayObjects;
			m_map = (map == null) ? noMap : map;
		}
		
		override public function hasNext():Boolean
		{
			return m_displayObjects.length > m_iteratorIndex;
		}
		
		override public function next():*
		{
			var itemToRaster:Object = m_displayObjects[m_iteratorIndex++];
			return m_map(itemToRaster);
		}
		
		private var noMap:Function = function(item:DisplayObject):DisplayObject {
			return this;
		};
	}
}