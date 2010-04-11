package com.ffsys.events {
	
	import com.ffsys.utils.array.ArrayUtils;
	
	//import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Concrete implementation of <code>IEventFilters</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public class EventFilters extends EventElement
		implements IEventFilters {
	
	//TODO: re-implement
	/*
		implements	IEventFilters,
		 			IDeserializeProperty {
	*/
		
		/**
		*	@private	
		*/
		private var _eventTable:IEventTable;
		
		/**
		*	@private
		*/
		private var _filters:Array;
		
		/**
		*	Creates an <code>EventFilters</code> instance.
		*	
		*	@param eventTable The event table this instance is filtering.
		*/
		public function EventFilters( eventTable:IEventTable = null )
		{
			super();
			this.eventTable = eventTable;
		}
		
		/*
		*	IDestroy implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/
		public function destroy():void
		{
			if( eventTable )
			{
				eventTable.destroy();
			}
			
			_filters = null;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function set eventTable( val:IEventTable ):void
		{
			_eventTable = val;
		}
		
		public function get eventTable():IEventTable
		{
			return _eventTable;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function addEventFilter( eventType:String ):void
		{
			//ignore null values
			if( !eventType )
			{
				return;
			}
			
			if( !_filters )
			{
				_filters = new Array();
			}
			
			if( eventTable )
			{
				if( eventTable.getEventTypeListener( eventType ) == null )
				{
					throw new Error(
						"IEventFilters, cannot add a filter that does not exist in the IEventTable: " +
							eventType );
				}
			}
			
			_filters.push( eventType );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function removeEventFilter( eventType:String ):void
		{
			var i:int = 0;
			var l:int = _filters.length;
			
			for( ;i < l;i++ )
			{
				if( _filters[ i ] == eventType )
				{
					//-->
					//_filters = _filters.splice( i, 1 );
					
					_filters.splice( i, 1 );
					return;
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getFilteredEventTable():IEventTable
		{
			//no registered filters
			if( !filters )
			{
				return eventTable;
			}
			
			var filtered:IEventTable = new EventTable();
			var eventType:String;
			
			for( eventType in eventTable.table )
			{
				if( ArrayUtils.contains( filters, eventType ) )
				{
					filtered.addEventTypeListener(
						eventType,
						eventTable.getEventTypeListener( eventType )
					);
				}
			}
			
			return filtered;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get filters():Array
		{
			return _filters;
		}
		
		/*
		*	IDeserializeProperty implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/		
		public function setDeserializedProperty(
			name:String,
			value:Object ):void
		{
			addEventFilter( "" + value );
		}
	}
}