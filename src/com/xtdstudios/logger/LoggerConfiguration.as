package com.xtdstudios.logger
{
	

	public interface LoggerConfiguration
	{
		function get LogLevel(): LoggerLevel
		function set LogLevel(loggerLevel: LoggerLevel): void
		function shouldLog(classNameToLog: String, loggerLevel: LoggerLevel): Boolean
		function addFilterClass(classToLog: *, loggerLevel: LoggerLevel): void
		function addFilter(classToLog: String, loggerLevel: LoggerLevel): void
	}
}