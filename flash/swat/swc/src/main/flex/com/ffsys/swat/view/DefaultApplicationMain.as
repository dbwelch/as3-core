package com.ffsys.swat.view {
	
	import flash.events.Event;
	import flash.display.Sprite;
	
	import com.ffsys.swat.core.DefaultFlashVariables;
	import com.ffsys.swat.configuration.ConfigurationParser;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class DefaultApplicationMain extends Sprite {
		
		/**
		*	Creates a <code>DefaultApplicationMain</code> instance.
		*/
		public function DefaultApplicationMain()
		{
			super();
		}
		
		/**
		*	Gets the classes that will be linked
		*	during the application code preload phase.
		*	
		*	These are the classes that the compiler will link
		*	to the second frame.
		*	
		*	@return The classes	that will be linked on the
		*	second frame of the generated movie.
		*/
		public function getRuntimeClasses():Array
		{
			return [
				DefaultApplication,
				DefaultFlashVariables,
				ConfigurationParser,
				DefaultApplicationPreloadView ];
		}
	}
}