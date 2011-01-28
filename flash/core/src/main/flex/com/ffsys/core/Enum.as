package com.ffsys.core
{
	/**
	*	Represents an enumerable list.
	* 
	* 	This implementation can mutate the list dynamically
	* 	so could be considered to be an <em>expando</em> enum
	* 	as opposed to a fixed enum.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.01.2011
	*/
	//TODO: extend proxy
	dynamic public class Enum extends Object
	{
		private var _id:uint;
		private var _name:String;
		private var _enumerables:Vector.<Enum>;
		
		/**
		* 	Creates an <code>Enum</code> instance.
		*/
		public function Enum()
		{
			super();
		}
		
		/**
		* 	An identifier for this enum.
		*/
		public function get id():uint
		{
			return _id;
		}
		
		public function set id( value:uint ):void
		{
			_id = value;
		}
		
		/**
		* 	A name for this enum.
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		/**
		* 	The list of enumerables for this enum.
		*/
		public function get enumerables():Vector.<Enum>
		{
			if( _enumerables == null )
			{
				_enumerables = new Vector.<Enum>();
			}
			return _enumerables;
		}
		
		/**
		* 	Adds an enum to this enum.
		* 
		* 	@param enum The enum to add.
		* 
		* 	@return Whether the enum was added.
		*/
		public function add( enum:Enum ):Boolean
		{
			if( enum != null && enum != this )
			{
				enumerables.push( enum );
			}
			return false;
		}
		
		/**
		* 	Sets the list of enumerables from a source object.
		* 
		* 	@param value An <code>Enum</code>
		* 	or <code>Vector.&lt;Enum&gt;</code>.
		*/
		public function set source( value:Object ):void
		{
			if( value == null )
			{
				_enumerables = null;
				return;
			}
			//TODO: Vector.<String>, Vector.<uint>, Vector.<Object>
			var enums:Vector.<Enum> = new Vector.<Enum>();
			if( value is Enum )
			{
				enumerables.push( value as Enum );
			}else if( value is Vector.<Enum> )
			{
				_enumerables = enumerables.concat( value as Vector.<Enum> );
			}
		}
	}
}