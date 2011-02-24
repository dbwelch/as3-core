package com.ffsys.w3c.dom
{
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;
	
	/**
	*	Represents <code>DOM</code> node list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class NodeListImpl extends AbstractNodeProxyImpl
		implements NodeList
	{
		private var _children:Vector.<Node>;
		
		/**
		* 	Creates a <code>NodeListImpl</code> instance.
		*/
		public function NodeListImpl()
		{
			super();
			
			//update our proxy source to the child vector
			setProxySource( this.children );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return children.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):Node
		{
			return children[ index ];
		}
		
		
		/**
		* 	Retrieves a list of all nodes of the specified
		* 	type.
		* 
		* 	The output list will include this node if it is of
		* 	the specified and any direct descendant nodes that
		* 	are of the correct type. If the deep parameter is true
		* 	recursion is performed to retrieve all descendant nodes
		* 	of the specified type.
		* 
		* 	@param type The node type.
		* 	@param deep Whether to retrieve all descendant
		* 	
		* 	@return A list of all child nodes of the specified type.
		*/
		public function getNodesOfType(
			type:uint,
			deep:Boolean = false,
			output:NodeListImpl = null ):NodeList
		{
			if( output == null )
			{
				output = new NodeListImpl();
			}
			
			var node:Node = null;
			for( var i:int = 0;i < length;i++ )
			{
				node = item( i );
				if( node.nodeType == type )
				{
					output.children.push( node );
				}
				if( deep && node.hasChildNodes() )
				{
					NodeListImpl( node.childNodes ).getNodesOfType(
						type, deep, output );
				}
			}
			return output;
		}
		
		/**
		* 	The first node in this collection
		* 	if it is not empty.
		*/
		public function get firstChild():Node
		{
			if( length > 0 ) 
			{
				return item( 0 );
			}
			return null;
		}
		
		/**
		* 	The last node in this collection
		* 	if it is not empty.
		*/
		public function get lastChild():Node
		{
			if( length > 0 ) 
			{
				return item( length -1 );
			}
			return null;
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
			var child:Node = null;
			for( var i:int = 0;i < parameters.length;i++ )
			{
				param = parameters[ i ];
				if( param is Node
					&& children.indexOf( param ) == -1 )
				{
					children.push( Node( param ) );
				}else if( param is NodeList
					&& NodeList( param ).length > 0 )
				{
					//children = children.concat( NodeList( param ).children );
					for each( child in NodeList( param ) )
					{
						concat( child );
					}
				}
			}
		}
		
		/**
		* 	Removes a node from this list.
		* 
		* 	@param node The node to remove.
		* 
		* 	@return A boolean indicating whether the node
		* 	was removed from this list.
		*/
		public function remove( node:Node ):Boolean
		{
			for( var i:int = 0;i < children.length;i++ )
			{
				if( node == children[ i ] )
				{
					children.splice( i, 1 );
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	@private
		*/
		override protected function propertyMissing( name:* ):*
		{
			var num:Number = Number( name );
			//return null rather then throw a
			//RangeError for the moment
			if( !isNaN( num )
				&& ( num >= length || num < 0 ) )
			{
				return null;
			}
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