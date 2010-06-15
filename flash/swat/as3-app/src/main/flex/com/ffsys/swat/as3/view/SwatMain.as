package com.ffsys.swat.as3.view {
	
	import com.ffsys.swat.view.SwatApplicationMain;
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	[Frame(factoryClass="com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloader")]
	public class SwatMain extends SwatApplicationMain {
		
		/**
		*	@private
		*	
		*	Force compiling of dependent classes.
		*/
		private static var _application:SwatActionscriptApplication;
		
		/**
		*	Creates a <code>SwatMain</code> instance.
		*/
		public function SwatMain()
		{
			super();
		}
	}
}