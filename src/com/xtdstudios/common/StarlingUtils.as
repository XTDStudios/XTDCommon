/**
 * Created by gil on 05/10/2015.
 */
package com.xtdstudios.common
{
	import starling.display.DisplayObject;

	public class StarlingUtils
	{
		public static function CenterPivot(dispObj:DisplayObject):void {
			var currentX : Number = dispObj.x;
			var currentY : Number = dispObj.y;
			dispObj.pivotX = dispObj.width/2;
			dispObj.pivotY = dispObj.height/2;
			dispObj.x = currentX + dispObj.pivotX;
			dispObj.y = currentY + dispObj.pivotY;
		}
	}
}
