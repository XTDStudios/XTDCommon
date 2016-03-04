/**
 * Created by rotem on 04/03/16.
 */
package com.xtdstudios.utils {
import flash.events.TimerEvent;
import flash.utils.Timer;

public class DelayedTask {
    private var timer:Timer;

    public function DelayedTask(idleTime:Number, task:Function) {
        timer = new Timer(idleTime, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerTimeout);
        timer.start();

        function onTimerTimeout(event:TimerEvent):void {
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerTimeout);
            timer.stop();
            task();
        }
    }

    public function cancel(): Boolean {
        if (timer.running) {
            timer.stop();
            return true;
        } else return false;
    }

}
}
