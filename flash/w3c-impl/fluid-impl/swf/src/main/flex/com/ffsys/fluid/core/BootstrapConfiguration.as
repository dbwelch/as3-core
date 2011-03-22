package com.ffsys.fluid.core
{
	import org.flashx.swat.configuration.ClassPathConfiguration;
	
	/**
	*	Configures the bootstrap class paths.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.01.2011
	*/
	public class BootstrapConfiguration extends ClassPathConfiguration
	{
		/**
		* 	Creates a <code>BootstrapConfiguration</code> instance.
		*/
		public function BootstrapConfiguration()
		{
			super();
		}
		
		/**
		* 	Gets the class path to the flash variables implementation
		* 	to use.
		*/
		override public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.fluid.core.ApplicationFlashVariables";
		}
		
		/**
		* 	Gets the class path to the main preload
		* 	view for the application.
		*/
		override public function getPreloadViewClassPath():String
		{
			return "com.ffsys.fluid.view.ApplicationPreloadView";
		}
	}
}