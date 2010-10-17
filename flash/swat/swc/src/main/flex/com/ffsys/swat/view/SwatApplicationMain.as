package com.ffsys.swat.view {
	
	import flash.events.Event;
	import flash.display.Sprite;
	
	import com.ffsys.swat.core.SwatFlashVariables;
	
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatApplicationMain extends Sprite {
		
		/**
		*	Creates a <code>SwatApplicationMain</code> instance.
		*/
		public function SwatApplicationMain()
		{
			super();
		}
		
		/**
		*	Gets the classes that will be linked
		*	during the application code preload phase.
		*	
		*	These are the classes that the compiler will link
		*	to the first frame to handle the preloading of the
		*	code on the second frame.
		*	
		*	@return The classes	that will be linked on the
		*	first frame of the generated movie.
		*/
		public function getRuntimeClasses():Array
		{
			return [
				SwatApplication,
				SwatFlashVariables,
				ApplicationPreloadView ];
		}
	}
}