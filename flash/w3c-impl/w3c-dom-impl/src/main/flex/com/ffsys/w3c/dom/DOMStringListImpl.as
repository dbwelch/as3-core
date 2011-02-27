package com.ffsys.w3c.dom
{
	import org.w3c.dom.DOMStringList;
	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	
	/**
	* 	Encapsulates a list of string values.
	*/
	dynamic public class DOMStringListImpl extends AbstractNodeProxyImpl
		implements DOMStringList
	{
		private var _list:Vector.<String>;
		
		/**
		* 	Creates a <code>DOMStringListImpl</code> instance.
		* 
		* 	@param values A list of string values to add to
		* 	this list implementation.
		*/
		public function DOMStringListImpl( ...values )
		{
			super();
			setProxySource( this.list );
			var item:Object = null;
			for( var i:int = 0;i < values.length;i++ )
			{
				item = values[ i ];
				if( item is String )
				{
					this.list.push( item as String );
				}
			}
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
		override public function get length():uint
		{
			return list.length;
		}
	}
}