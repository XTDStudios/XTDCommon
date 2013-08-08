package com.xtdstudios.logger
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class SimpleLoggerConfiguration implements LoggerConfiguration
	{
		private static var s_loggerConfiguration: LoggerConfiguration = null;
		
		
		public static function instance(): LoggerConfiguration
		{
			if (!s_loggerConfiguration)
			{
				s_loggerConfiguration = new SimpleLoggerConfiguration();
			}
			return s_loggerConfiguration;
		}

		private var defaultLoggerLevel: LoggerLevel = LoggerLevel.DEBUG;
		private var logFilters: Dictionary = new Dictionary();
		private var implicitLogFilters: Dictionary = new Dictionary();
		
		public function SimpleLoggerConfiguration()
		{
		}
		
		public function get LogLevel(): LoggerLevel
		{
			return this.defaultLoggerLevel
		}
		public function set LogLevel(loggerLevel: LoggerLevel):void
		{
			this.defaultLoggerLevel = loggerLevel;
		}
		
		public function addFilterClass(classToLog: *, loggerLevel: LoggerLevel): void
		{
			addFilter(getQualifiedClassName(classToLog), loggerLevel);
		}
		
		public function addFilter(classToLog: String, loggerLevel: LoggerLevel): void
		{
			logFilters[classToLog] = loggerLevel;
		}
		
		protected function getFilter(classToLog: String): LoggerLevel
		{
			var logLevel : LoggerLevel = logFilters[classToLog];
			if (! logLevel)
			{
				var classPackagePath: String = classToLog;
				var lastIndex: int = classToLog.lastIndexOf("::");
				while (! logLevel && lastIndex > 0)
				{
					classPackagePath = classPackagePath.substring(0,lastIndex);
					logLevel = logFilters[classPackagePath];
					lastIndex = classPackagePath.lastIndexOf(".");
				}
				
				if (! logLevel)
				{
					logLevel = defaultLoggerLevel;
				}
			}
			
			return logLevel;
		}
		
		public function shouldLog(classNameToLog: String, loggerLevel: LoggerLevel): Boolean
		{
			if (getFilter(classNameToLog) == loggerLevel)
			{
				return true;
			}
			return false; 
		}
	}
}