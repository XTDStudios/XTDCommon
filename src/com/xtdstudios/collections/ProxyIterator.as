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
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	dynamic public class ProxyIterator extends Proxy implements Iterator
	{
		protected var m_iteratorIndex : int;
		
		public function ProxyIterator()
		{
			super();
			m_iteratorIndex = 0;
		}
		
		public function hasNext():Boolean
		{
			// Should be implement by extenders
			return false;
		}
		public function next():*
		{
			// Should be implement by extenders
			throw new IllegalOperationError("No elements");
		}
		
		override flash_proxy function nextNameIndex (index:int):int {
			// This is the command to move to the next item or start over (index == 0)
			// return an incremented index when there is data
			// return 0 when you are done.
			return hasNext() ? m_iteratorIndex+1 : 0;
		}
		
		override flash_proxy function nextValue(index:int):* {
			// This is the command to get the data
			// The index that is passed in is the index returned in nextNameIndex
			return next();
		}
	}
}