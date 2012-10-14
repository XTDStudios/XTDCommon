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
				var cls : Class = m_applicationDomain.getDefinition(symbol) as Class;
				return new cls;
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