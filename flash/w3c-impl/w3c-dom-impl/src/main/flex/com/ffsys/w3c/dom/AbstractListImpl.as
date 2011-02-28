package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;
	import org.w3c.dom.NodeList;
	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	
	/**
	*	An abstract super class for <code>Node</code> lists.
	* 
	* 	Many DOM interfaces define an <code>item</code> method
	* 	in conjunction with a <code>length</code> as a list abstraction.
	* 
	* 	This class provides the core functionality for the list
	* 	including the <code>length</code> property and the ability
	* 	to enumerate the list using <code>for..in</code> and
	* 	<code>for..each..in</code> loops but expects derived
	* 	implementations to define the <code>item</code> method
	* 	of the appropriate Node type.
	*/
	dynamic public class AbstractListImpl extends AbstractNodeProxyImpl
	{
		private var _children:Vector.<Node>;
		
		/**
		* 	Creates a <code>AbstractListImpl</code> instance.
		* 
		* 	@param contents Any Node or NodeList implementations
		* 	to add to this node list, when a NodeList is encountered
		* 	the contents of the NodeList are added to this implementation.
		*/
		public function AbstractListImpl( ...contents )
		{
			super();
			//update our proxy source to the child vector
			setProxySource( this.children );
			this.concat.apply( this, contents );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return children.length;
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
			output:NodeList = null ):NodeList
		{
			if( output == null )
			{
				//TODO: retrieve via a this.clone() operation
				output = new NodeListImpl();
			}
			
			var node:Node = null;
			for( var i:int = 0;i < length;i++ )
			{
				node = _children[ i ];
				if( node.nodeType == type )
				{
					AbstractListImpl( output ).children.push( node );
				}
				if( deep && node.hasChildNodes() )
				{
					AbstractListImpl( node.childNodes ).getNodesOfType(
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
			if( _children.length > 0 ) 
			{
				return _children[ 0 ];
			}
			return null;
		}
		
		/**
		* 	The last node in this collection
		* 	if it is not empty.
		*/
		public function get lastChild():Node
		{
			if( _children.length > 0 )
			{
				return _children[ _children.length -1 ];
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