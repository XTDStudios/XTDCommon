package com.xtdstudios.logger
{
	import com.xtdstudios.as3.Enum;

	public final class LoggerLevel extends Enum
	{
		{initEnum(LoggerLevel);} // static ctor
		
		public static const DEBUG	: LoggerLevel = new LoggerLevel();
		public static const INFO	: LoggerLevel = new LoggerLevel();
		public static const WARN	: LoggerLevel = new LoggerLevel();
		public static const ERROR	: LoggerLevel = new LoggerLevel();
	}
}