package com.ffsys.dom.core
{
	import org.w3c.dom.*;	

	public class DOMStringListImpl extends Object
		implements DOMStringList
	{
		private var _list:Vector.<String>;
		
		/**
		* 	Creates a <code>DOMStringListImpl</code> instance.
		*/
		public function DOMStringListImpl()
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
		* 	@inheritDoc
		*/
		public function item( index:uint ):String
		{
			return list[ index ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function contains( str:String ):Boolean
		{
			return list.indexOf( str ) > -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return list.length;
		}
	}
}