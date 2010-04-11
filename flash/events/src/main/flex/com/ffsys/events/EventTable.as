package com.ffsys.events {
	
	import flash.utils.Dictionary;
	
	/**
	*	Represents a table between event type String
	*	values and the corresponding listener function
	*	that should listen for the Event.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public class EventTable extends EventElement
		implements IEventTable {
		
		/**
		*	@private	
		*/
		private var _table:Dictionary;
		
		/**
		*	Creates an <code>EventTable</code> instance.
		*/
		public function EventTable()
		{
			super();
			_table = new Dictionary( true );
		}
		
		/*
		*	IDestroy implementation.	
		*/
		
		/**
		*	@inheritDoc
		*/
		public function destroy():void
		{
			var key:String;
			
			for( key in _table )
			{
				_table[ key ] = null;
				delete _table[ key ];
			}
			_table = null;
		}		
		
		/**
		*	@inheritDoc
		*/		
		public function get table():Dictionary
		{
			return _table;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function addEventTypeListener(
			eventType:String,
			listener:Function ):void
		{
			_table[ eventType ] = listener;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getEventTypeListener(
			eventType:String ):Function
		{
			return _table[ eventType ];
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removeEventTypeListener(
			eventType:String ):void
		{
			delete _table[ eventType ];
		}
	}
}