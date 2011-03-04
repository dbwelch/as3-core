package com.ffsys.events {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	* 	Responsible for handling global event notification.
	*
	* 	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	* 	@since  20.05.2007
	*/
	public class Notification extends EventDispatcher {
		
		/**
		*	@private	
		*/
		private var _sourceTarget:IEventDispatcher;
		
		/**
		*	@private	
		*/
		public function Notification()
		{
			super();
		}
		
		/**
		*	The source <code>IEventDispatcher</code> that generated
		*	this notification if available.
		*/
		public function set sourceTarget( val:IEventDispatcher ):void
		{
			_sourceTarget = val;
		}
		
		public function get sourceTarget():IEventDispatcher
		{
			return _sourceTarget;
		}
	}
}