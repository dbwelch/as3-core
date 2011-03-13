package com.ffsys.w3c.dom
{
	import org.w3c.dom.Attr;
	import org.w3c.dom.Document;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.Element;
	import org.w3c.dom.Node;
	import org.w3c.dom.NodeList;	
	import org.w3c.dom.NodeType;
	
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
		override public function hasChildNodes():Boolean
		{
			return childNodes.length > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function hasAttributes():Boolean
		{
			return attributes.length  > 0;
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
			
			if( newChild == refChild )
			{
				// stupid case that must be handled as a no-op triggering events...
				refChild = refChild.nextSibling;
				removeChild( newChild );
				insertBefore( newChild, refChild );
				return newChild;
			}
			
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
				for( var a:Node = this; treeSafe && a != null; a = a.parentNode )
				{
					treeSafe = newChild != a;
				}
				if( !treeSafe )
				{
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

			//remove from any existing parent node
			var oldparent:Node = newInternal.parentNode;
			if( oldparent != null )
			{
				oldparent.removeChild( newInternal );
			}

			// Convert to internal type, to avoid repeated casting
			var refInternal:ChildNode = ChildNode( refChild );

			// Attach up
			newInternal.setOwnerNode( this );
			newInternal.setIsOwned( true );
			
			/*

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
				
				/*
				if( _ownerDocument != null )
				{
					n.setOwnerDocument( _ownerDocument );
				}
				*/
				
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

	        checkNormalizationAfterInsert( newInternal );
			return newChild;
		}
		
		/**
		* 	@private
		* 
		*	Checks the normalized state of this node after inserting a child.
		* 
		*	<p>If the inserted child causes this node to be unnormalized, then this
		*	node is flagged accordingly.</p>
		* 
		* 	<p>The conditions for changing the normalized state are:</p>
		* 
		* 	<ul>
		* 		<li>The inserted child is a text node and one of its adjacent siblings
		* is also a text node.</li>
		* 		<li>The inserted child is is itself unnormalized.</li>
		*	</ul>
		*
		* 	@param insertedChild the child node that was inserted into this node.
		*
		*	@throws NullPointerException if the inserted child is <code>null</code>.
		*/
		protected function checkNormalizationAfterInsert( insertedChild:ChildNode ):void
		{
	        // See if insertion caused this node to be unnormalized.
	        if( insertedChild.nodeType == NodeType.TEXT_NODE )
			{
	            var prev:Node = insertedChild.previousSibling;
	            var next:Node = insertedChild.nextSibling;
	
	            // If an adjacent sibling of the new child is a text node,
	            // flag this node as unnormalized.
	            if( ( prev != null && prev.nodeType == NodeType.TEXT_NODE )
					|| ( next != null && next.nodeType == NodeType.TEXT_NODE ) )
				{
	                setIsNormalized( false );
	            }
	        }
	        else {
	            // If the new child is not normalized,
	            // then this node is inherently not normalized.
	            if( !insertedChild.isNormalized() )
				{
	                setIsNormalized( false );
	            }
	        }
	    }
		
		/**
		* 	@private
		* 	
		* 	DOM Level 3 WD- Experimental.
		*	Override inherited behavior from NodeImpl to support deep equal.
		*/
	    override public function isEqualNode( arg:Node ):Boolean
		{
	        if( !super.isEqualNode( arg ) )
			{
	            return false;
	        }
	
	        // there are many ways to do this test, and there isn't any way
	        // better than another. Performance may vary greatly depending on
	        // the implementations involved. This one should work fine for us.
	        var child1:Node = firstChild;
	        var child2:Node = arg.firstChild;
	        while( child1 != null && child2 != null )
			{
	            if( !child1.isEqualNode( child2 ) )
				{
	                return false;
	            }
	            child1 = child1.nextSibling;
	            child2 = child2.nextSibling;
	        }
	
	        if( child1 != child2 )
			{
	            return false;
	        }
	        return true;
	    }
	
		/**
		* 	@private
		*/
		override internal function setOwnerDocument( owner:Document ):void
		{
			if( needsSyncChildren() )
			{
				synchronizeChildren();
			}
			
			super.setOwnerDocument( owner );
			
			//also update child nodes
			var child:ChildNode = firstChild as ChildNode;
	        while( child != null )
			{
	            child.setOwnerDocument( owner );
				child = child.nextSibling as ChildNode;
	        }
		}	
	
		/**
		* 	@private
		* 	
		* 	Override default behavior so that if deep is true, children are also
		*	toggled.
		*
		*	Note: this will not change the state of an EntityReference or its
		*	children, which are always read-only.
		*/
	    override internal function setReadOnly( readOnly:Boolean, deep:Boolean ):void
		{
	        super.setReadOnly( readOnly, deep );
	        if( deep )
			{
	            if( needsSyncChildren() )
				{
	                synchronizeChildren();
	            }
				var mykid:ChildNode = firstChild as ChildNode;
	            // Recursively set kids
	            while( mykid != null )
				{
	                if( mykid.nodeType != NodeType.ENTITY_REFERENCE_NODE )
					{
	                    mykid.setReadOnly( readOnly, true );
	                }
					mykid = mykid.nextSibling as ChildNode;
	            }
	        }
	    }
		
		/**
		* 	@private
		* 	
		*	Override default behavior to call normalize() on this Node's
		*	children. It is up to implementors or Node to override normalize()
		*	to take action.
		*/
		override public function normalize():void
		{	
			// No need to normalize if already normalized.
			if( isNormalized() )
			{
				return;
			}
			if( needsSyncChildren() )
			{
				synchronizeChildren();
			}
			var kid:Node;
			for( kid = firstChild; kid != null; kid = kid.nextSibling )
			{
				kid.normalize();
			}
			setIsNormalized( true );
		}
	}
}