package com.ffsys.dom
{
	
	/**
	*	Represents <code>DOM</code> node list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class NodeList extends XmlAwareDomElement
	{
		private var _children:Vector.<Node>;
		
		/**
		* 	Creates a <code>NodeList</code> instance.
		*/
		public function NodeList()
		{
			super();
			
			//update our proxy source to the child vector
			setSource( children );
		}
		
		/**
		* 	The number of nodes in this list.
		*/
		override public function get length():uint
		{
			return _children.length;
		}
		
		/**
		* 	Gets a node at the specified index.
		*/
		public function item( index:uint ):Node
		{
			return children[ index ];
		}
		
		/**
		* 	Clears the nodes stored by this list.
		*/
		public function clear():void
		{
			_children.splice( 0, _children.length );
		}
		
		/**
		* 	The child nodes in this list.
		*/
		public function get children():Vector.<Node>
		{
			if( _children == null )
			{
				_children = new Vector.<Node>();
			}
			return _children;
		}
		
		public function set children( value:Vector.<Node> ):void
		{
			_children = value;
		}
		
		/**
		* 	@private
		*/
		override protected function propertyMissing( name:* ):*
		{
			return children[ name ];
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			return "[object " + getClassName() + "(" + length + ")] " + children.join( "," );
		}
	}
}