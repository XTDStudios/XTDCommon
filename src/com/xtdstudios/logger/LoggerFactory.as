package com.xtdstudios.logger
{
	public class LoggerFactory
	{
		private static var m_loggerFactory: LoggerFactory;
		public static function get instance(): LoggerFactory
		{
			if (! m_loggerFactory) 
			{
				m_loggerFactory = new LoggerFactory();
			}
			return m_loggerFactory;
		}
		
		public static function getLogger(classToLog: *): Logger
		{
			return instance.getLogger(classToLog);
		}
		
		private var m_factoryMethod: Function;
//		private var m_loggerClass: Class;
		
		public function LoggerFactory()
		{
			m_factoryMethod = defaultFactoryMethod;
		}
		
		public function getLogger(classToLog: *): Logger
		{
			return m_factoryMethod(classToLog);
		}
		
//		public function set loggerClass(loggerClass: Class): void
//		{
//			m_loggerClass = loggerClass;
//		}
//		
		public function set factoryMethod(factory: Function): void
		{
			m_factoryMethod = factory;
		}
		
		private function defaultFactoryMethod(classToLog: *): Logger
		{
			return new TraceLogger(classToLog);
		}
	}
}