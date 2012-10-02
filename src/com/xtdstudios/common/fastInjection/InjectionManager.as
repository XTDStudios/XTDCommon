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
package com.xtdstudios.common.fastInjection
{
	import flash.utils.Dictionary;

	public class InjectionManager
	{
		private var m_injectables	: Dictionary;
		private var m_injectInto	: Dictionary;
		
		public function InjectionManager(injectables:Vector.<InjectableData> = null)
		{
			m_injectInto = new Dictionary();
			m_injectables = new Dictionary();
			addInjectable(this, "injectionManager", false);
			if (injectables)
			{
				var injectableData:InjectableData;
				for each(injectableData in injectables)
				{
					addInjectable(injectableData.injectableObj, injectableData.injectedAs, false);
				}
				
				for each(injectableData in injectables)
				{
					if (injectableData.injectableObj.hasOwnProperty("postConstruct"))
						injectableData.injectableObj.postConstruct();
				}
			}
		}
		
		public function process(injectInto:Object, callPostConstruct:Boolean=true):void
		{
			if (m_injectInto[injectInto]==null)
			{
				m_injectInto[injectInto] = injectInto;
				processInjections(injectInto as Object);
				if (callPostConstruct && injectInto.hasOwnProperty("postConstruct"))
					injectInto.postConstruct();
			}
		}
		
		public function clear(injectInto:Object):void
		{
			if (m_injectInto[injectInto]!=null)
			{
				if (injectInto.hasOwnProperty("dispose"))
					injectInto.dispose();

				removeInjections(injectInto);
				delete m_injectInto[injectInto];
			}
		}
		
		public function addInjectable(injectable:Object, injectedAs:String, callPostConstruct:Boolean=true):void
		{
			if (m_injectables[injectedAs]==null)
			{
				m_injectables[injectedAs] = injectable;
				process(injectable, callPostConstruct)
			}
		}
		
		public function removeInjectable(injectedAs:String):void
		{
			if (m_injectables[injectedAs]!=null)
			{
				clear(m_injectables[injectedAs]);
				delete m_injectables[injectedAs];
			}
		}
		
		private function processInjections(injectInto:Object):void
		{
			for (var injectedAs:String in m_injectables)
			{
				var currentInjectable:Object = m_injectables[injectedAs];
				if (currentInjectable!=injectInto)
				{
					if (injectInto.hasOwnProperty(injectedAs))
					{
						injectInto[injectedAs] = currentInjectable;
					}
				}
			}
		}
		
		private function removeInjections(injectedInto:Object):void
		{
			// never remove the InjectionManager
			if (injectedInto==this)
				return;
			
			for (var injectedAs:String in m_injectables)
			{
				var currentInjectable:Object = m_injectables[injectedAs];
				if (currentInjectable!=injectedInto)
				{
					if (injectedInto.hasOwnProperty(injectedAs))
					{
						injectedInto[injectedAs] = null;
					}
				}
			}
		}
		
		public function dispose():void
		{
			for (var injectedAs:String in m_injectables)
			{
				removeInjectable(injectedAs);
			}
		}
	}
}