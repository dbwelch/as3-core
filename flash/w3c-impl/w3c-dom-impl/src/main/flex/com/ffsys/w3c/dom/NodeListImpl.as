package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;
	import org.w3c.dom.NodeList;
	
	/**
	*	Represents a <code>Node</code> list.
	*/
	dynamic public class NodeListImpl extends AbstractListImpl
		implements NodeList
	{
		/**
		* 	Creates a <code>NodeListImpl</code> instance.
		* 
		* 	@param contents Any Node or NodeList implementations
		* 	to add to this node list, when a NodeList is encountered
		* 	the <em>contents of the NodeList</em> are added to
		* 	this list.
		*/
		public function NodeListImpl( ...contents )
		{
			super();
			this.concat.apply( this, contents );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):Node
		{
			return _children[ index ];
		}
	}
}