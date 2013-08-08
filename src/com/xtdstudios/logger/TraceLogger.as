package com.xtdstudios.logger
{
	import flash.utils.getQualifiedClassName;

	public class TraceLogger implements Logger
	{
		private static var s_loggerConfiguration: LoggerConfiguration = SimpleLoggerConfiguration.instance();
		private var classNameToLog: String = "";
		
		
		public function TraceLogger(classToLog: *)
		{
			classNameToLog = getQualifiedClassName(classToLog);
		}

		public function log(level: LoggerLevel, message: String): Boolean
		{
			if (s_loggerConfiguration.shouldLog(classNameToLog, level))
			{
				var date: Date = new Date();
				var dateStr : String =  date.getDate()+"/"+date.getMonth()+"/"+date.getFullYear() + " " +  date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+"."+date.getMilliseconds();
//				var messageStr:String = "{0} [{1}] {2} - {3}";
//				trace(StringUtil.substitute(messageStr, dateStr, level, classNameToLog, message));
				trace(dateStr,"[",level,"]",classNameToLog,"-",message);
				
				return true;
			}
			return false
		}
		
		
		public function debug(message: String): void
		{
			log(LoggerLevel.DEBUG, message);
		}
		
		public function info(message: String): void
		{
			log(LoggerLevel.INFO, message);
		}
		
		public function warn(message: String): void
		{
			log(LoggerLevel.WARN, message);
		}
		
		public function error(message: String): void
		{
			log(LoggerLevel.ERROR, message);
		}
	}
}