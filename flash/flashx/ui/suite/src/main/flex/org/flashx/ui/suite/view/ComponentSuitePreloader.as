package org.flashx.ui.suite.view
{
	import org.flashx.swat.view.DefaultApplicationPreloader;
	
	import org.flashx.ui.suite.core.ComponentSuiteClassPathConfiguration;
	import org.flashx.ui.suite.view.ComponentSuitePreloadView;
	
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