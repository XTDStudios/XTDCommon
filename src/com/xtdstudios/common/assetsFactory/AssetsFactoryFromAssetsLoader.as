package com.xtdstudios.common.assetsFactory
{
	import com.xtdstudios.common.assetsLoader.IAssetsLoader;
	
	import flash.errors.IllegalOperationError;
	
	public class AssetsFactoryFromAssetsLoader implements IAssetsFactory
	{
		private var m_assetsLoader			: IAssetsLoader;
		
		public function AssetsFactoryFromAssetsLoader(assetsLoader:IAssetsLoader)
		{
			m_assetsLoader = assetsLoader;
		}
		
		public function createAsset(symbol:String):Object
		{
			if (m_assetsLoader)
			{
				var cls : Class = m_assetsLoader.getAssetClass(symbol);
				return new cls;
			}
			else
			{
				new IllegalOperationError("assetsLoader was not set on AssetsFactoryFromAssetsLoader");
				return null;
			}
		}
		
		public function dispose():void
		{
			m_assetsLoader = null;
		}
	}
}