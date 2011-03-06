package java.util
{
	import flash.utils.Dictionary;
	
	import java.lang.*;
	
	/**
	* 	
	*/
	public class AbstractMap extends JavaObject
		implements Map
	{
		private var _dictionary:Array = new Array();
		
		private var _keyType:K = null;
		private var _valueType:V = null;
		private var _hashCode:int = -1;
		
		/**
		* 	Creates a <code>AbstractMap</code> instance.
		* 
		* 	@param k The key type.
		* 	@param v The value type.
		*/
		public function AbstractMap( k:K = null, v:V = null )
		{
			super();
			this.keyType = k;
			this.valueType = v;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get keyType():K
		{
			return _keyType;
		}
		
		public function set keyType( value:K ):void
		{
			_keyType = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get valueType():V
		{
			return _valueType;
		}
		
		public function set valueType( value:V ):void
		{
			_valueType = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function clear():void
		{
			_dictionary = new Array();
		}
		
		/**
		*	@inheritDoc
		*/
		public function containsKey( key:Object ):Boolean
		{
			return indexOf( key ) > -1;
		}
		
		/**
		*	@inheritDoc
		*/
		public function containsValue( value:Object ):Boolean
		{
			return indexOfValue( value ) > -1;
		}
		
		/**
		*	@inheritDoc
		*/
		public function item( key:Object ):Object
		{
			var entry:MapEntry = _dictionary[ key ];
			if( entry != null )
			{
				return entry.value;
			}
			return null;
		}
		
		/**
		* 	Retrieves a value at the specified index.
		* 
		* 	@param index The index of the value.
		*/
		public function index( index:uint ):Object
		{
			var value:Object = _dictionary[ index ];
			if( value is MapEntry )
			{
				value = MapEntry( value ).value;
			}
			return value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function keySet():Set
		{
			var output:Set = new HashSet();
			var entry:MapEntry = null;
			for( var i:int = 0;i < _dictionary.length;i++ )
			{
				entry = MapEntry( _dictionary[ i ] );
				output.add( entry.key );
			}
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function entrySet():Set
		{
			var output:Set = new HashSet();
			var entry:MapEntry = null;
			for( var i:int = 0;i < _dictionary.length;i++ )
			{
				entry = MapEntry( _dictionary[ i ] );
				output.add( entry );
			}
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function put( key:Object, value:Object ):Object
		{
			if( key == null )
			{
				throw new ArgumentError( "The key for a map may not be null." );
			}
			
			if( this.keyType != null && !( key is keyType.type ) )
			{
				throw new ArgumentError( "The map key must be a '" + keyType.type + "' type." );
			}
			
			var entry:MapEntry = null;
			var index:int = indexOf( key );
			
			if( index == -1 )
			{
				index = size();
				entry = new MapEntry( key, value, index );
			}else{
				entry = _dictionary[ index ] as MapEntry;
			}
			
			entry.key = key;
			entry.value = value;
			
			_dictionary[ index ] = entry;
			_dictionary[ key ] = entry;
			
			return value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function remove( key:Object ):Object
		{
			var entry:MapEntry = null;
			var index:int = indexOf( key );
			if( index > -1 )
			{
				entry = _dictionary[ index ] as MapEntry;
				var key:Object = entry.key;
				var value:Object = entry.value;
				entry.key = null;
				entry.value = null;
				//remove the entry
				_dictionary.splice( index, 1 );
				delete _dictionary[ key ];
				return value;
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function equals( o:Object ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function putAll( m:Map ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return ( size() === 0 );
		}
		
		/**
		*	@inheritDoc
		*/
		public function size():int
		{
			return _dictionary.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function values():Collection
		{
			var output:Collection = new ArrayList();
			var entry:MapEntry = null;
			for( var i:int = 0;i < _dictionary.length;i++ )
			{
				entry = MapEntry( _dictionary[ i ] );
				
				trace("[ADDING MAP ENTRY VALUE] AbstractMap::values()", entry.value );
				
				output.add( entry.value );
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function iterator():Iterator
		{
			return new AbstractMapIterator( this );
		}
		
		/**
		* 	@private
		*/
		protected function indexOf( key:Object ):int
		{
			var entry:MapEntry = null;
			for( var i:int = 0;i < _dictionary.length;i++ )
			{
				entry = _dictionary[ i ] as MapEntry;
				if( entry != null
				 	&& entry.key === key )
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		* 	@private
		*/
		protected function indexOfValue( value:Object ):int
		{
			var entry:MapEntry = null;
			for( var i:int = 0;i < _dictionary.length;i++ )
			{
				entry = _dictionary[ i ] as MapEntry;
				if( entry != null
				 	&& entry.value === value )
				{
					return i;
				}
			}
			return -1;
		}
	}
}

import java.util.Iterator;
import java.util.AbstractMap;

class AbstractMapIterator implements Iterator {
	
	private var _map:AbstractMap;
	private var _index:uint = 0;
	
	/**
	* 	Creates a <code>AbstractMapIterator</code> instance.
	*/
	public function AbstractMapIterator( map:AbstractMap )
	{
		super();
		_map = map;
	}
	
	/**
	* 	@inheritDoc
	*/
	public function hasNext():Boolean
	{
		return ( _index < _map.size() );
	}
	
	/**
	* 	@inheritDoc
	*/
	public function next():*
	{
		var value:* = _map.index( _index );
		_index++;
		return value;
	}
	
	/**
	* 	@inheritDoc
	*/
	public function remove():void
	{
		//TODO
	}
}