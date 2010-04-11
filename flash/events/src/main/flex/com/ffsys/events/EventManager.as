package com.ffsys.events {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Concrete implementation of <code>IEventManager</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public class EventManager extends EventElement
		implements IEventManager {
		
		/**
		*	@private	
		*/
		protected var _targetDispatcher:IEventDispatcher;
		
		/**
		*	@private	
		*/
		protected var _eventFilters:IEventFilters;
		
		/**
		*	Creates an <code>EventManager</code> instance.
		*	
		*	@param targetDispatcher The default target
		*	<code>IEventDispatcher</code>.
		*	@param eventFilters The event filters to use
		*	when adding and removing listeners.
		*/
		public function EventManager(
			targetDispatcher:IEventDispatcher = null,
			eventFilters:IEventFilters = null )
		{
			super();
			this.targetDispatcher = targetDispatcher;
			this.eventFilters = eventFilters;
		}
		
		/*
		*	IDestroy implementation.	
		*/
		
		/**
		*	@inheritDoc
		*/
		public function destroy():void
		{
			if( eventFilters )
			{
				eventFilters.destroy();
			}
			
			if( targetDispatcher )
			{
				removeListeners( targetDispatcher );
			}
			
			eventFilters = null;
			targetDispatcher = null;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function set targetDispatcher( val:IEventDispatcher ):void
		{
			_targetDispatcher = val;
		}
		
		public function get targetDispatcher():IEventDispatcher
		{
			return _targetDispatcher;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function set eventFilters( val:IEventFilters ):void
		{
			_eventFilters = val;
		}
		
		public function get eventFilters():IEventFilters
		{
			return _eventFilters;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function addListeners(
			target:IEventDispatcher = null ):void
		{
			if( !target )
			{
				target = targetDispatcher;
			}
			
			if( !target )
			{
				throw new Error( "IEventManager, cannot add listeners to a null target." );
			}
			
			removeListeners( target );
			
			var eventTable:IEventTable = eventFilters.getFilteredEventTable();
			
			if( eventTable )
			{
				var eventType:String;
				var method:Function;
				for( eventType in eventTable.table )
				{
					method = eventTable.table[ eventType ];
					target.addEventListener( eventType, method, false, 0, true );
				}
			}
						
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removeListeners( target:IEventDispatcher = null ):void
		{
			if( !target )
			{
				target = targetDispatcher;
			}
			
			if( !target )
			{
				throw new Error( "IEventManager, cannot add listeners to a null target" );
			}
			
			//we always remove all registered events
			//not just the filtered ones
			var eventTable:IEventTable = eventFilters.eventTable;
			
			if( eventTable )
			{
				var eventType:String;
				var method:Function;
				for( eventType in eventTable.table )
				{
					method = eventTable.table[ eventType ];
					target.removeEventListener( eventType, method );
				}
			}
			
		}		
		
		/**
		*	@inheritDoc
		*/		
		public function addNotifierListeners():void
		{
			addListeners( Notifier.getInstance() );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removeNotifierListeners():void
		{
			removeListeners( Notifier.getInstance() );
		}	
	}
}