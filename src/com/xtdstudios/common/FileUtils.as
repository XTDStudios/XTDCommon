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
package com.xtdstudios.common
{
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class FileUtils
	{
		//TODO: Add constant to be set depends on the device type (CONFIG::) 
		private const m_cacheDir : File = new File(File.applicationStorageDirectory.nativePath+"/../../cache");
		//private const DEVICE_CACHE_PATH : String = new File(File.applicationDirectory.nativePath +"/\.\./Library/Caches");
		
		//TODO: Add constant to be set depends on the device type (CONFIG::) - 
		//TODO: chech the right pos per device
		private const m_tempDir : File = new File(File.applicationDirectory.nativePath +"/\.\./tmp");
		
		public function FileUtils()
		{
		}
		
		public function getCacheDir():File
		{
			return m_cacheDir;
		}
		
		
		public function getTempDir():File
		{
			return m_tempDir;
		}
		
		public function saveToPNGFile(bitmapData:BitmapData, filePath:String):void
		{
			var imgByteArray	: ByteArray;
			imgByteArray = new ByteArray();
			bitmapData.encode(new Rectangle(0, 0, bitmapData.width, bitmapData.height), new PNGEncoderOptions(true), imgByteArray);
			
			var fs:FileStream = new FileStream();
			var fl:File = new File(filePath);
			try
			{
				//open file in write mode
				fs.open(fl, FileMode.WRITE);
				//write bytes from the byte array
				fs.writeBytes(imgByteArray);
				//close the file
				fs.close();
			}
			catch(e:Error)
			{
				trace(e.message);
			}
		}
	}
}