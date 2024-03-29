package org.flashx.ui.dom
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
		implements IDomNodeList
	{
		private var _children:Vector.<Node>;
		
		/**
		* 	Creates a <code>NodeList</code> instance.
		*/
		public function NodeList()
		{
			super();
		}
		
		/**
		* 	The number of nodes in this list.
		*/
		public function get length():uint
		{
			return children.length;
		}
		
		/**
		* 	Gets a node at the specified index.
		*/
		public function item( index:uint ):Node
		{
			return children[ index ];
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
	}
}