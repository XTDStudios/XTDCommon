package com.xtdstudios.logger
{
	public interface Logger
	{
		function log(level: LoggerLevel, message: String): Boolean
		function debug(message: String): void
		function info(message: String): void
		function warn(message: String): void
		function error(message: String): void
	}
}