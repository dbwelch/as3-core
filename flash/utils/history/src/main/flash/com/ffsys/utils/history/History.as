package com.ffsys.utils.history {
	
	import flash.events.EventDispatcher;

	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	<code>History</code> instances maintain a
	*	list of history items.
	*	
	*	In addition, <code>History</code> instances
	*	maintain a pointer that can be modified to
	*	change the <code>item</code> that the instance
	*	currently points to.
	*	
	*	To change the current history <code>item</code>
	*	that the instance points to modify the
	*	<code>position</code> property.
	*	
	*	<code>History</code> instances maintain a
	*	<code>maximum</code> number of items they can
	*	store prior to purging.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.09.2007
	*/
	public class History extends EventDispatcher
		implements IHistory {
		
		/**
		*	@private	
		*/
		protected var _history:Array;
		
		/**
		*	@private	
		*/		
		protected var _position:int;
		
		/**
		*	@private	
		*/		
		protected var _maximum:int;
		
		/**
		*	@private	
		*/		
		protected var _strict:Boolean;
		
		/**
		*	@private	
		*/		
		protected var _allowNullValues:Boolean;
		
		/**
		*	@private	
		*/		
		protected var _allowDuplicateValues:Boolean;
		
		/**
		*	Creates a new <code>History</code> instance.
		*	
		*	@param maximum The maximum number of items
		*	this instance should store.
		*	@param allowDuplicateValues Determines whether
		*	duplicate values are allowed.
		*	@param allowNullValues Determines whether
		*	<code>null</code> values are allowed.
		*/		
		public function History(
			maximum:int = 0,
			allowDuplicateValues:Boolean = true,
			allowNullValues:Boolean = false )
		{
			super();
			clear();
			this.maximum = maximum;
			
			this.allowNullValues = allowNullValues;
			this.allowDuplicateValues = allowDuplicateValues;
			
			_position = 0;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function contains( value:Object ):Boolean
		{
			return ArrayUtils.contains( _history, value );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function addHistoryItem( value:Object ):void
		{
			
			if( !allowNullValues && !value && !( value is Boolean ) )
			{
 				if( strict )
				{
					throw new HistoryError( HistoryError.NULL_VALUE );
				}
				
				return;
			}
			
			if( !allowDuplicateValues )
			{
				if( contains( value ) )
				{
	 				if( strict )
					{
						throw new HistoryError( HistoryError.VALUE_EXISTS, value );
					}
					return;
				}
			}
			
			_history.push( value );
			
			if( maximum && getLength() > maximum )
			{
				_history.shift();
			}
			
			update();
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function update():void
		{
			//we don't want to dispatch the event
			//when the position is updated manually
			_position = _history.length - 1;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getHistoryItemAt( index:int ):Object
		{
			if( index < 0 || index > ( getLength() - 1 ) )
			{
				return null;
			}
			
			return _history[ index ];
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function removeHistoryItem( value:Object ):Boolean
		{
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				if( _history[ i ] == value )
				{
					removeHistoryItemAt( i );
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function removeHistoryItemAt( index:int ):Object
		{
			if( !isValidIndex( index ) )
			{
				return null;
			}
			
			var removed:Object = _history.splice( index, 1 );
			
			return removed;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function first():Boolean
		{
			if( isEmpty() )
			{
				return false;
			}
			
			position = 0;
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function last():Boolean
		{
			if( isEmpty() )
			{
				return false;
			}
			
			position = getLength() - 1;
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function hasPrevious():Boolean
		{
			return ( !isEmpty() && hasItems() && position > 0 );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function hasNext():Boolean
		{
			return ( !isEmpty() && hasItems() && ( position < ( getLength() - 1 ) ) );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function previous():Boolean
		{
			if( !hasPrevious() )
			{
				return false;
			}
			
			position--;
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function next():Boolean
		{
			if( !hasNext() )
			{
				return false;
			}
			
			position++;
			return true;
		}
		
		protected function isValidIndex( index:int ):Boolean
		{
			return ( !isEmpty() && index >= 0 && ( index <= ( getLength() - 1 ) ) );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set position( index:int ):void
		{
			if( index < 0 || ( index > getLength() - 1 ) )
			{
				if( strict )
				{
					//throw new Error( "History: invalid index, cannot set the position to " + index );
					
					throw new HistoryError( HistoryError.INVALID_POSITION, index, getLength() );
				}
				
				return;
			}
			
			if( index == _position )
			{
				return;
			}
			
			_position = index;
			
			//dispatch change event here
			dispatchEvent( new HistoryEvent( HistoryEvent.CHANGE ) );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get position():int
		{
			return _position;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get item():Object
		{
			return _history[ position ];
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set maximum( val:int ):void
		{
			_maximum = val;
			
			//if the number of stored items
			//exceeds the maximum being set
			//chop the difference off the beginning
			//of the stored items
			if( val && getLength() > val )
			{
				_history = _history.slice( getLength() - val );
				
				//if the position was outside
				//the updated history items
				//send it to the end - keep
				//it within bounds
				if( position > ( getLength() - 1 ) )
				{
					last();
				}
				
			}
			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get maximum():int
		{
			return _maximum;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getLength():int
		{
			return _history.length;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function hasItems():Boolean
		{
			return getLength() > 1;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function isEmpty():Boolean
		{
			return ( _history.length == 0 );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function clear():void
		{
			_history = new Array();
		}

		/**
		*	@inheritDoc	
		*/
		public function set strict( val:Boolean ):void
		{
			_strict = val;
		}
		
		public function get strict():Boolean
		{
			return _strict;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set allowDuplicateValues( val:Boolean ):void
		{
			_allowDuplicateValues = val;
		}
		
		public function get allowDuplicateValues():Boolean
		{
			return _allowDuplicateValues;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set allowNullValues( val:Boolean ):void
		{
			_allowNullValues = val;
		}
		
		public function get allowNullValues():Boolean
		{
			return _allowNullValues;
		}			
	}	
}