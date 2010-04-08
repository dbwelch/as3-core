package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.text.StyleSheet;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IStylesheetAccess;
	import com.ffsys.io.loaders.resources.StylesheetResource;
	
	/**
	*	Event dispatched when stylesheet CSS data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class StylesheetLoadEvent extends LoadEvent
		implements IStylesheetAccess {
		
		public function StylesheetLoadEvent(
			event:Event,
			loader:ILoader,
			resource:StylesheetResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get stylesheet():StyleSheet
		{
			return StylesheetResource( resource ).stylesheet;
		}
		
		override public function clone():Event
		{
			return new StylesheetLoadEvent(
				triggerEvent, loader, StylesheetResource( resource ) );
		}		
		
	}
	
}
