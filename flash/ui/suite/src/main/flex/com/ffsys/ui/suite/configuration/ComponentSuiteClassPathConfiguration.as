package com.ffsys.ui.suite.configuration
{
	import com.ffsys.swat.configuration.ClassPathConfiguration;
	
	/**
	*	Custom class path configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class ComponentSuiteClassPathConfiguration extends ClassPathConfiguration
	{		
		/**
		* 	Creates a <code>ComponentSuiteClassPathConfiguration</code> instance.
		*/
		public function ComponentSuiteClassPathConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getPreloadViewClassPath():String
		{
			return "com.ffsys.ui.suite.view.ComponentSuitePreloadView";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getMainViewClassPath():String
		{
			return "com.ffsys.ui.suite.view.ComponentSuiteContainer";
		}
	}
}