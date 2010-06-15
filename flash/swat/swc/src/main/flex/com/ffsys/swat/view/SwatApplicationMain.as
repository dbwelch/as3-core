package com.ffsys.swat.view {
	
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
		
		private static var _application:SwatApplication;
		private static var _view:ApplicationPreloadView;
		private static var _flashvars:SwatFlashVariables;
		
		/**
		*	Creates a <code>SwatApplicationMain</code> instance.
		*/
		public function SwatApplicationMain()
		{
			super();
		}
		
		public function getRuntimeClasses():Array
		{
			return [
				SwatApplication,
				SwatFlashVariables,
				ApplicationPreloadView ];
		}
	}
}