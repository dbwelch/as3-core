package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.net.URLVariables;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.types.IVariableAccess;
	import com.ffsys.io.loaders.resources.VariableResource;
	
	/**
	*	Event dispatched when URLVariables data has been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class VariableLoadEvent extends LoadEvent
		implements IVariableAccess {
		
		public function VariableLoadEvent(
			event:Event,
			loader:ILoader,
			resource:VariableResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get vars():URLVariables
		{
			return VariableResource( resource ).vars;
		}
		
		override public function clone():Event
		{
			return new VariableLoadEvent( triggerEvent, loader, VariableResource( resource ) );
		}			
		
	}
	
}
