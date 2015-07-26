/**
 * Created by R on 5/9/2015.
 */
package com.xtdstudios.utils {
import flash.utils.getTimer;

public class TimeUtils {

    //
    public function TimeUtils(Abstract:Lock, Error:* = "This this static utils class. Can not instantiate.                                                                                                 ") {
        ConstructorValidator(Abstract, Error);
    }

    // Get time since the epoch and time since the VM was started
    private static const dateTime:Number = new Date().time;
    private static const dateTimestamp:uint = getTimer();

    /**
     * Current time in ms
     */
    public static function get currentCurrentTimeMilliseconds ():Number {
        return dateTime + (getTimer() - dateTimestamp);
    }
}
}
internal class Lock {
}
internal const _abstractLock:Lock = new Lock;
