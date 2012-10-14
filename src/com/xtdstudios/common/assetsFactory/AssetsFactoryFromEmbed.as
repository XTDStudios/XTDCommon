package com.xtdstudios.common.assetsFactory
{
	import flash.errors.IllegalOperationError;

	public class AssetsFactoryFromEmbed implements IAssetsFactory
	{
		private var m_objectWithEmbeds			: Object;

		public function AssetsFactoryFromEmbed(objectWithEmbeds	: Object)
		{
			m_objectWithEmbeds = objectWithEmbeds;
		}
		
		public function createAsset(symbol:String):Object
		{
			if (m_objectWithEmbeds)
			{
				var cls : Class = m_objectWithEmbeds[symbol];
				return new cls;
			}
			else
			{
				new IllegalOperationError("objectWithEmbeds was not set on AssetsFactoryFromEmbed");
				return null;
			}
		}
		
		public function dispose():void
		{
			m_objectWithEmbeds = null;
		}
	}
}