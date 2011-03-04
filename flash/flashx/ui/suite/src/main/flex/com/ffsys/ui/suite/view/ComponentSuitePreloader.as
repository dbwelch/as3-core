package com.ffsys.ui.suite.view
{
	import com.ffsys.swat.view.DefaultApplicationPreloader;
	
	import com.ffsys.ui.suite.core.ComponentSuiteClassPathConfiguration;
	import com.ffsys.ui.suite.view.ComponentSuitePreloadView;
	
	/**
	*	Custom application preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ComponentSuitePreloader extends DefaultApplicationPreloader
	{		
		/**
		* 	Creates a <code>ComponentSuitePreloader</code> instance.
		*/
		public function ComponentSuitePreloader()
		{
			super();
		}
		
		override public function getRuntimeClasses():Array
		{
			var output:Array = super.getRuntimeClasses();
			output.push( ComponentSuiteClassPathConfiguration );
			output.push( ComponentSuitePreloadView );
			return output;
		}
	}
}