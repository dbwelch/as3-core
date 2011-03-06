package java.util
{

	public class AbstractList extends AbstractCollection
		implements List
	{
		
		/**
		* 	
		*/
		public function AbstractList()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function iterator():Iterator
		{
			return new ListIterator( this );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):Object
		{
			return this.items[ index ];
		}
	}
}


import java.util.Iterator;
import java.util.List;

class ListIterator implements Iterator {
	
	private var _list:List;
	private var _index:uint = 0;
	
	/**
	* 	Creates a <code>ListIterator</code> instance.
	*/
	public function ListIterator( list:List )
	{
		super();
		_list = list;
	}
	
	/**
	* 	@inheritDoc
	*/
	public function hasNext():Boolean
	{
		return ( _index < _list.size() );
	}
	
	/**
	* 	@inheritDoc
	*/
	public function next():*
	{
		var value:* = _list.item( _index );
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