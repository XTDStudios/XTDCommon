package com.xtdstudios.common.assetsFactory
{
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;

	public class AssetsFactoryFromApplicationDomain implements IAssetsFactory
	{
		private var m_applicationDomain			: ApplicationDomain;

		public function AssetsFactoryFromApplicationDomain(applicationDomain:ApplicationDomain)
		{
			m_applicationDomain = applicationDomain;
		}
		
		public function createAsset(symbol:String):Object
		{
			if (m_applicationDomain)
			{
				trace(m_applicationDomain.getQualifiedDefinitionNames());
				
				var definition : Object = m_applicationDomain.getDefinition(symbol);
				if (definition is Class)
				{
					var cls : Class = m_applicationDomain.getDefinition(symbol) as Class;
					return new cls;
				}
				else
				{
					return definition;
				}
			}
			else
			{
				new IllegalOperationError("applicationDomain was not set on AssetsFactoryFromApplicationDomain");
				return null;
			}
		}
		
		public function dispose():void
		{
			m_applicationDomain = null;
		}
	}
}