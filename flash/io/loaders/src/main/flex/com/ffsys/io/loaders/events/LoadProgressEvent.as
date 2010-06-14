package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Represents a progress event dispatched during
	*	the loading of an external resource.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class LoadProgressEvent extends LoadEvent {
		
		static public const LOAD_PROGRESS:String = "loadProgress";
		
		public function LoadProgressEvent(
			event:ProgressEvent,
			loader:ILoader )
		{
			super( LOAD_PROGRESS, event, loader );
		}
		
		override public function get bytesLoaded():uint
		{
			if( event )
			{
				return event.bytesLoaded;
			}
			
			return 0;
		}
		
		override public function get bytesTotal():uint
		{
			if( event )
			{
				return event.bytesTotal;
			}
			
			return 0;
		}
		
		public function get normalized():Number
		{
			if( event )
			{
				return ( bytesLoaded / bytesTotal ) * 1;
			}
			
			return -1;
		}
		
		public function get percentLoaded():int
		{
			if( event )
			{
				return Math.floor( ( bytesLoaded / bytesTotal ) * 100 );
			}
			
			return -1;
		}
		
		override public function clone():Event
		{
			return new LoadProgressEvent( event, loader );
		}
		
		public function get event():ProgressEvent
		{
			return triggerEvent as ProgressEvent;
		}
	}
}