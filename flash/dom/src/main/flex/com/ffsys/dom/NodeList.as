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
		* 	Clears the nodes stored by this list.
		*/
		public function clear():void
		{
			children.splice( 0, children.length );
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
		* 	Adds parameters to this node list.
		* 
		* 	If a parameter is a node it is added, if a
		* 	parameter is a node list the elements stored
		* 	in the node list are added.
		* 
		* 	@param parameters Nodes to add to this list.
		*/
		public function concat( ...parameters ):void
		{	
			var param:Object = null;
			for( var i:int = 0;i < parameters.length;i++ )
			{
				param = parameters[ i ];
				if( param is Node )
				{
					children.push( Node( param ) );
				}else if( param is NodeList
					&& NodeList( param ).length > 0 )
				{
					children = children.concat( NodeList( param ).children );
				}
			}
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
		
		/**
		* 	@private
		*/
		override protected function getNextName( index:int ):String
		{
			return ( index + 1 ).toString();
		}
		
		/**
		* 	@private
		*/
		override protected function getNextValue( index:int ):*
		{
			return children[ index - 1 ];
		}		
	}
}