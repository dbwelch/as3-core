package com.ffsys.dom.core
{

	public class DomStringList extends Object
	{
		private var _list:Vector.<String>;
		
		/**
		* 	Creates a <code>DomStringList</code> instance.
		*/
		public function DomStringList()
		{
			super();
		}
		
		/**
		* 	The encapsulated list of string values.
		* 
		* 	Operating on this <code>Vector</code> will
		* 	modify the intenal state of this list.
		*/
		public function get list():Vector.<String>
		{
			if( _list == null )
			{
				_list = new Vector.<String>();
			}
			return _list;
		}
		
		/**
		* 	Retrieves a string from the list
		* 	at the specified index.
		*/
		public function item( index:uint ):String
		{
			return list[ index ];
		}
		
		/**
		* 	Determines whether this list contains
		* 	the specified string.
		*/
		public function contains( str:String ):Boolean
		{
			return list.indexOf( str ) > -1;
		}
		
		/**
		* 	The number of strings in this list.
		*/
		public function get length():uint
		{
			return list.length;
		}
	}
}