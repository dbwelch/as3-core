package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;
	
	/**
	* 	Abstract super class for all nodes that
	* 	may appear as child nodes.
	* 
	* 	That is to say <em>all</em> node implementations.
	*/
	public class ChildNode extends NodeImpl
	{
	    private var _previousSibling:ChildNode;
	    private var _nextSibling:ChildNode;
		
		/**
		* 	Creates a <code>ChildNode</code> instance.
		* 
		* 	@param owner The owner of the node.
		*/
		public function ChildNode( owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
	    /**
		* 	@inheritDoc
		*/
		
		/*
		override public function get parentNode():Node
		{
			// if we have an owner, ownerNode is our parent, otherwise it's
			// our ownerDocument and we don't have a parent
			return isOwned() ? ownerNode : null;
	    }
		*/
	
		/**
		* 	@inheritDoc
		*/
		
		/*
	    override public function get previousSibling():Node
		{
	        // if we are the firstChild, previousSibling actually refers to our
	        // parent's lastChild, but we hide that
	        return isFirstChild() ? null : _previousSibling;
	    }
		*/
	
		/**
		* 	@private
		*/
		internal function setPreviousSibling( node:ChildNode ):void
		{
			_previousSibling = node;
		}
	
		/**
		* 	@inheritDoc
		*/
		
		/*
	    override public function get nextSibling():Node
		{
	        return _nextSibling;
	    }
		*/
		
		/**
		* 	@private
		*/
		internal function setNextSibling( node:ChildNode ):void
		{
			_nextSibling = node;
		}
		
		/**
		* 	@inheritDoc
		*/
	    override public function cloneNode( deep:Boolean ):Node
		{
			var newnode:ChildNode = ChildNode(
				super.cloneNode( deep ) );
			
			// Need to break the association w/ original kids
			newnode.setPreviousSibling( null );
			newnode.setNextSibling( null );
			
			//TODO: re-integrate
			//newnode.isFirstChild( false );
			
			return newnode;
	    }
	}
}