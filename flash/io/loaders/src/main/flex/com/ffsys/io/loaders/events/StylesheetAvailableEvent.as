package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Event broadcast when a stylesheet has been fully loaded
	*	in to the StyleManager.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public class StylesheetAvailableEvent extends LoadEvent {
		
		static public const STYLESHEET_AVAILABLE:String = "stylesheetAvailable";
		
		public function StylesheetAvailableEvent( loader:ILoader )
		{
			super(
				STYLESHEET_AVAILABLE,
				new Event( Event.COMPLETE ),
				loader );
		}
		
	}
	
}
