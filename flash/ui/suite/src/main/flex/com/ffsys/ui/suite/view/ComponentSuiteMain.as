package com.ffsys.ui.suite.view {
	
	import com.ffsys.swat.view.DefaultApplicationMain;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	[Frame(factoryClass="com.ffsys.ui.suite.view.ComponentSuitePreloader")]
	public class ComponentSuiteMain extends DefaultApplicationMain {
		
		/**
		*	Creates a <code>ComponentSuiteMain</code> instance.
		*/
		public function ComponentSuiteMain()
		{
			super();
		}
		
		override public function getRuntimeClasses():Array
		{
			var output:Array = new Array();
			output.push( ComponentSuiteContainer );
			return output;
		}
	}
}