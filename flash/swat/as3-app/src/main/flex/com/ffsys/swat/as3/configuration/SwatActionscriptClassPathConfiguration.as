package com.ffsys.swat.as3.configuration
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
	public class SwatActionscriptClassPathConfiguration extends ClassPathConfiguration
	{
		/**
		* 	Creates a <code>SwatActionscriptClassPathConfiguration</code> instance.
		*/
		public function SwatActionscriptClassPathConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getMainClassPath():String
		{
			return "com.ffsys.swat.as3.view.SwatActionscriptApplication";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.swat.as3.core.ApplicationFlashVariables";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getPreloadViewClassPath():String
		{
			return "com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloadView";
		}		
	}
}