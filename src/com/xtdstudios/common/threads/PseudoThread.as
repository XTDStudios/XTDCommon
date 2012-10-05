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
package com.xtdstudios.common.threads
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class PseudoThread extends EventDispatcher {
		
		private var m_timer				: Timer;
		private var m_targetFPS			: int;
		private var m_timeToSpend		: Number;
		private var m_avgTimeSpent		: Number;
		private var m_countExecutions	: int;
		private var m_runnable			: IRunnable;
		
		public function PseudoThread(runnable:IRunnable, targetFPS:int = 60) {
			m_runnable = runnable;
			m_targetFPS = targetFPS;
			m_timeToSpend = 1000/m_targetFPS;
			m_avgTimeSpent = 0;
			m_countExecutions = 0;
			m_timer = new Timer(m_timeToSpend);
			m_timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		public function destroy():void 
		{
			m_timer.stop();
			m_timer.removeEventListener(TimerEvent.TIMER,onTimer);
			m_runnable = null;
			m_timer = null;
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			var maxTime		: Number = getTimer()+m_timeToSpend-(m_avgTimeSpent*2);
			var startTime 	: Number;
			var endTime 	: Number;
			var timeTaken 	: Number;
			
			do {
				startTime = getTimer();
				m_runnable.process();
				m_countExecutions++;
				endTime = getTimer();
				timeTaken = endTime - startTime;
				if (m_countExecutions>1)
					m_avgTimeSpent = (m_avgTimeSpent + timeTaken)/2;
				else
					m_avgTimeSpent = timeTaken;
				
				//trace(maxTime, startTime, endTime, timeTaken, m_avgTimeSpent);
			} while (m_runnable.isComplete()==false && endTime<maxTime);
			
			if (m_runnable.isComplete()) 
			{
				m_timer.stop();
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, m_runnable.getProgress(), m_runnable.getTotal()));
				dispatchEvent(new Event(Event.COMPLETE,false,false));
				destroy();
			} 
			else
			{
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, m_runnable.getProgress(), m_runnable.getTotal()));
			}
		}
		
		public function start():void 
		{
			m_timer.start(); 
		}
		
	}
}