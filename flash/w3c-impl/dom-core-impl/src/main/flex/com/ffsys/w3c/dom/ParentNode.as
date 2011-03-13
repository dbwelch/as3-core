package com.ffsys.w3c.dom
{
	import org.w3c.dom.Attr;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.Element;
	import org.w3c.dom.Node;
	import org.w3c.dom.NodeList;	
	
	/**
	* 	Abstract super class for nodes that may have
	* 	child nodes.
	*/
	public class ParentNode extends ChildNode
	{
		private static var __nodeSelectorImpl:NodeSelectorImpl = new NodeSelectorImpl();
		
		/**
		* 	Creates a <code>ParentNode</code> instance.
		* 
		* 	@param owner The owner of the node.
		*/
		public function ParentNode( owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
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
		* 	
		*	Override this method in subclass to hook in efficient
		*	internal data structure.
		*/
		protected function synchronizeChildren():void
		{
			//By default just change the flag to avoid calling this method again
			setNeedsSyncChildren( false );
		}
		
		/**
		* 	@private
		*/
		protected function internalInsertBefore(
			newChild:Node, refChild:Node, replace:Boolean ):Node
		{
			var owner:CoreDocumentImpl = ownerDocument as CoreDocumentImpl;
			var errorChecking:Boolean = owner.errorChecking;
			
			/*
	        if (newChild.getNodeType() == Node.DOCUMENT_FRAGMENT_NODE) {
	            // SLOW BUT SAFE: We could insert the whole subtree without
	            // juggling so many next/previous pointers. (Wipe out the
	            // parent's child-list, patch the parent pointers, set the
	            // ends of the list.) But we know some subclasses have special-
	            // case behavior they add to insertBefore(), so we don't risk it.
	            // This approch also takes fewer bytecodes.

	            // NOTE: If one of the children is not a legal child of this
	            // node, throw HIERARCHY_REQUEST_ERR before _any_ of the children
	            // have been transferred. (Alternative behaviors would be to
	            // reparent up to the first failure point or reparent all those
	            // which are acceptable to the target node, neither of which is
	            // as robust. PR-DOM-0818 isn't entirely clear on which it
	            // recommends?????

	            // No need to check kids for right-document; if they weren't,
	            // they wouldn't be kids of that DocFrag.
	            if (errorChecking) {
	                for (Node kid = newChild.getFirstChild(); // Prescan
	                     kid != null; kid = kid.getNextSibling()) {

	                    if (!ownerDocument.isKidOK(this, kid)) {
	                        throw new DOMException(
	                              DOMException.HIERARCHY_REQUEST_ERR, 
	                              DOMMessageFormatter.formatMessage(DOMMessageFormatter.DOM_DOMAIN, "HIERARCHY_REQUEST_ERR", null));
	                    }
	                }
	            }

	            while (newChild.hasChildNodes()) {
	                insertBefore(newChild.getFirstChild(), refChild);
	            }
	            return newChild;
	        }
			*/
			
			/*
	        if (newChild == refChild) {
	            // stupid case that must be handled as a no-op triggering events...
	            refChild = refChild.getNextSibling();
	            removeChild(newChild);
	            insertBefore(newChild, refChild);
	            return newChild;
	        }
			*/
			
			if( needsSyncChildren() )
			{
				synchronizeChildren();
			}
			
			if( errorChecking )
			{
				if(	isReadOnly() )
				{
					throw new DOMException(
						DOMException.NO_MODIFICATION_ALLOWED_MSG,
						null,
						DOMException.NO_MODIFICATION_ALLOWED_ERR );
				}
				
				if(	newChild.ownerDocument != ownerDocument
					&& newChild != ownerDocument )
				{
					throw new DOMException(
						DOMException.WRONG_DOCUMENT_MSG,
						null,
						DOMException.WRONG_DOCUMENT_ERR );			
				}
				
				/*
				if( !ownerDocument.isKidOK( this, newChild ) )
				{
					throw new DOMException(DOMException.HIERARCHY_REQUEST_ERR, 
					DOMMessageFormatter.formatMessage(DOMMessageFormatter.DOM_DOMAIN, "HIERARCHY_REQUEST_ERR", null));
				}
				*/
				
				// refChild must be a child of this node (or null)
				if( refChild != null
					&& refChild.parentNode != this )
				{
					throw new DOMException(
						DOMException.NOT_FOUND_MSG,
						null,
						DOMException.NOT_FOUND_ERR );					
				}

				// Prevent cycles in the tree
				// newChild cannot be ancestor of this Node,
				// and actually cannot be this
				var treeSafe:Boolean = true;
				var a:Node = this;
				while( treeSafe && a != null )
				{
					if( newChild == a )
					{
						trace("[FOUND PARENT THAT MATCHES CHILD] ParentNode::internalInsertBefore()", newChild, a );
						treeSafe = false;
						break;
					}
					a = a.parentNode;
				}
				
				/*
				for( var a:Node = this; treeSafe && a != null; )
				{
					treeSafe = ( newChild != a ) && a != null;
					a = a.parentNode;
				}
				*/
				
				trace("ParentNode::internalInsertBefore()", treeSafe );
				
				if( !treeSafe )
				{
					//throw new DOMException(DOMException.HIERARCHY_REQUEST_ERR, 
					//	DOMMessageFormatter.formatMessage(DOMMessageFormatter.DOM_DOMAIN, "HIERARCHY_REQUEST_ERR", null));
					
					throw new DOMException(
						DOMException.HIERARCHY_REQUEST_MSG,
						null,
						DOMException.HIERARCHY_REQUEST_ERR );					
				}
			}

	        // notify document
	        owner.insertingNode( this, replace );
	
	        // Convert to internal type, to avoid repeated casting
	        var newInternal:ChildNode = ChildNode( newChild );	
			
			/*

	        Node oldparent = newInternal.parentNode();
	        if (oldparent != null) {
	            oldparent.removeChild(newInternal);
	        }

	        // Convert to internal type, to avoid repeated casting
	        ChildNode refInternal = (ChildNode)refChild;

	        // Attach up
	        newInternal.ownerNode = this;
	        newInternal.isOwned(true);

	        // Attach before and after
	        // Note: firstChild.previousSibling == lastChild!!
	        if (firstChild == null) {
	            // this our first and only child
	            firstChild = newInternal;
	            newInternal.isFirstChild(true);
	            newInternal.previousSibling = newInternal;
	        }
	        else {
	            if (refInternal == null) {
	                // this is an append
	                ChildNode lastChild = firstChild.previousSibling;
	                lastChild.nextSibling = newInternal;
	                newInternal.previousSibling = lastChild;
	                firstChild.previousSibling = newInternal;
	            }
	            else {
	                // this is an insert
	                if (refChild == firstChild) {
	                    // at the head of the list
	                    firstChild.isFirstChild(false);
	                    newInternal.nextSibling = firstChild;
	                    newInternal.previousSibling = firstChild.previousSibling;
	                    firstChild.previousSibling = newInternal;
	                    firstChild = newInternal;
	                    newInternal.isFirstChild(true);
	                }
	                else {
	                    // somewhere in the middle
	                    ChildNode prev = refInternal.previousSibling;
	                    newInternal.nextSibling = refInternal;
	                    prev.nextSibling = newInternal;
	                    refInternal.previousSibling = newInternal;
	                    newInternal.previousSibling = prev;
	                }
	            }
	        }
			*/
			
	        changed();

			/*
	        // update cached length if we have any
	        if (fNodeListCache != null) {
	            if (fNodeListCache.fLength != -1) {
	                fNodeListCache.fLength++;
	            }
	            if (fNodeListCache.fChildIndex != -1) {
	                // if we happen to insert just before the cached node, update
	                // the cache to the new node to match the cached index
	                if (fNodeListCache.fChild == refInternal) {
	                    fNodeListCache.fChild = newInternal;
	                } else {
	                    // otherwise just invalidate the cache
	                    fNodeListCache.fChildIndex = -1;
	                }
	            }
	        }
			*/
			
			//
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
			
	        // notify document
	        owner.insertedNode( this, newInternal, replace );

	        //checkNormalizationAfterInsert(newInternal);
			
			return newChild;			
		}
	}
}