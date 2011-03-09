package com.ffsys.w3c.dom
{
	import org.w3c.dom.Element;
	import org.w3c.dom.Node;
	import org.w3c.dom.NodeList;	
	
	/**
	* 	Abstract super class for nodes that may have
	* 	child nodes.
	*/
	public class ParentNode extends ChildNode
	{
		/**
		* 	Creates a <code>ParentNode</code> instance.
		* 
		* 	@param owner The owner of the node.
		*/
		public function ParentNode( owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
			
		private static var __nodeSelectorImpl:NodeSelectorImpl = new NodeSelectorImpl();
		
		/**
		* 	@inheritDoc
		*/
		public function querySelector(
			selectors:String, ...referenceNodes ):Element
		{
			return __nodeSelectorImpl.querySelector.apply(
				__nodeSelectorImpl,
				[ selectors ].concat( referenceNodes ) );
		}
			
		/**
		* 	@inheritDoc
		*/
		public function querySelectorAll(
			selectors:String, ...referenceNodes ):NodeList
		{
			return __nodeSelectorImpl.querySelectorAll.apply(
				__nodeSelectorImpl,
				[ selectors ].concat( referenceNodes ) );
		}
			
		/**
		* 	@inheritDoc
		*/
		public function queryScopedSelector(
			selectors:String ):Element
		{
			return __nodeSelectorImpl.queryScopedSelector.apply(
				__nodeSelectorImpl,
				[ selectors ] );			
		}
			
		/**
		* 	@inheritDoc
		*/
		public function queryScopedSelectorAll(
			selectors:String ):NodeList
		{
			return __nodeSelectorImpl.queryScopedSelectorAll.apply(
				__nodeSelectorImpl,
				[ selectors ] );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function insertBefore( child:Node, before:Node ):Node
		{
			//This method can raise a DomException object.			
			return internalInsertBefore( child, before, false );
		}
		
		/**
		* 	@private
		*/
		protected function internalInsertBefore(
			newChild:Node, refChild:Node, replace:Boolean ):Node
		{
			if( newChild is NodeImpl )
			{
				var n:NodeImpl = NodeImpl( newChild );				
				n.setParentNode( this );
				n.setChildIndex( childNodes.length );
				
				if( _ownerDocument != null )
				{
					n.setOwnerDocument( _ownerDocument );
				}

				NodeListImpl( childNodes ).concat( n );
				
				if( _ownerDocument is CoreDocumentImpl && ( n is Element ) )
				{	
					CoreDocumentImpl( _ownerDocument ).registerElement( Element( n ) );
				}
				
				//TODO: property name camel case conversion
				
				//var name:String = n.nodeName;
					
				//also assign a reference by property name
				
				//this[ name ] = n;
				
				n.added();
			}
			
			return newChild;			
		}
	}
}