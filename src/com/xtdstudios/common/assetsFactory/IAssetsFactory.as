package com.xtdstudios.common.assetsFactory
{
	public interface IAssetsFactory
	{
		function createAsset(symbol:String):Object;
		function getAssetClass(className:String):Class;
		function dispose():void;
		
	}
}