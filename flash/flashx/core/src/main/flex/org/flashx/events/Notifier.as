package org.flashx.events {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	* 	Mono state for the <code>Notification</code>
	*	class that handles global event notification.
	*
	* 	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	* 	@since  20.05.2007
	*/
	public class Notifier extends Object {
		
		/**
		*	@private
		*	
		*	Stores a reference to the <code>Notification</code>
		*	instance.
		*/
		static private var _instance:Notification;
		
		/**
		*	@private
		*/
		public function Notifier()
		{
			super();
		}
		
		/**
		*	Gets the <code>Notification</code> instance.
		*
		*	@return The <code>Notification</code> instance.
		*/
		static public function getInstance():Notification
		{
			if( !_instance )
			{
				_instance = new Notification();
			}
			
			return _instance;
		}
		
		static public function addEventListener(
			type:String,
			listener:Function,
			useCapture:Boolean = false,
			priority:int = 0,
			useWeakReference:Boolean = false
		):void
		{
			getInstance().addEventListener(
				type, listener, useCapture, priority, useWeakReference );
		}
		
		static public function removeEventListener(
			type:String,
			listener:Function,
			useCapture:Boolean = false
		):void
		{
			getInstance().removeEventListener( type, listener, useCapture );
		}
		
		static public function hasEventListener( type:String ):Boolean
		{
			return getInstance().hasEventListener( type );
		}
		
		static public function dispatchEvent(
			event:Event,
			sourceTarget:IEventDispatcher = null ):Boolean
		{
			var notification:Notification = getInstance();
			notification.sourceTarget = sourceTarget;
			return getInstance().dispatchEvent( event );
		}
	}
}