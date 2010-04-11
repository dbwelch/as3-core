package com.ffsys.io.loaders.events {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.utils.flex.FlexUtils;
	
	/**
	*	Event dispatched when compiled stylesheet data
	*	has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class CompiledStylesheetLoadEvent extends LoadEvent {
		
		public function CompiledStylesheetLoadEvent(
			event:Event,
			loader:ILoader )
		{
			super( LoadEvent.DATA, event, loader );
		}
		
		public function loadStyleDeclarations():IEventDispatcher
		{
			var dispatcher:IEventDispatcher = null;
			
			var manager:Object = FlexUtils.getStyleManager();
			
			if( manager )
			{
				dispatcher =
					manager.loadStyleDeclarations( uri );
			}
			
			return dispatcher;
		}
		
		override public function clone():Event
		{
			return new CompiledStylesheetLoadEvent( triggerEvent, loader );
		}
		
	}
	
}
