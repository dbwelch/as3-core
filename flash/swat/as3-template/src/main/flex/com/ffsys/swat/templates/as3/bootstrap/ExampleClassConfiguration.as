package com.ffsys.swat.templates.as3.bootstrap
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
	public class ExampleClassConfiguration extends ClassPathConfiguration
	{		
		/**
		* 	Creates an <code>ExampleClassConfiguration</code> instance.
		*/
		public function ExampleClassConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.swat.templates.as3.bootstrap.ExampleFlashVariables";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getPreloadViewClassPath():String
		{
			return "com.ffsys.swat.templates.as3.view.ExampleApplicationPreloadView";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getMainViewClassPath():String
		{
			return "com.ffsys.swat.templates.as3.view.ExampleContainer";
		}
	}
}