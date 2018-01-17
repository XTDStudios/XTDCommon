/**
 * Created by gil on 05/10/2015.
 */
package com.xtdstudios.common {
import flash.system.Capabilities;

import starling.display.DisplayObject;

import flash.display3D.Context3DProfile;

public class StarlingUtils {
  public static function CenterPivot(dispObj:DisplayObject):void {
    var currentX:Number = dispObj.x;
    var currentY:Number = dispObj.y;
    dispObj.pivotX = dispObj.width / 2;
    dispObj.pivotY = dispObj.height / 2;
    dispObj.x = currentX + dispObj.pivotX;
    dispObj.y = currentY + dispObj.pivotY;
  }

  public static function Support4096Textures(profile: String):Boolean {
    return profile == Context3DProfile.BASELINE_EXTENDED ||
      profile == Context3DProfile.ENHANCED ||
      profile == Context3DProfile.STANDARD ||
      profile == Context3DProfile.STANDARD_CONSTRAINED ||
      profile == Context3DProfile.STANDARD_EXTENDED;
  }

  public static function get isMobile() : Boolean
  {
      return Capabilities.manufacturer.indexOf("iOS") > -1 || Capabilities.manufacturer.indexOf("Android") > -1;
  }

}
}
