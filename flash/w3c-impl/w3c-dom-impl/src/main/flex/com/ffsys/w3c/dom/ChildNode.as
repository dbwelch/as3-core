package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;

	public class ChildNode extends NodeImpl
	{
	    private var _previousSibling:ChildNode;
	    private var _nextSibling:ChildNode;
		
		/**
		* 	Creates a <code>ChildNode</code> instance.
		* 
		* 	@param owner 
		*/
		public function ChildNode( owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
	    /**
		* 	@inheritDoc
		*/
		override public function get parentNode():Node
		{
			// if we have an owner, ownerNode is our parent, otherwise it's
			// our ownerDocument and we don't have a parent
			return isOwned() ? ownerNode : null;
	    }
		
		/**
		* 	@inheritDoc
		*/
	    override public function cloneNode( deep:Boolean ):Node
		{

			var newnode:ChildNode = ChildNode(
				super.cloneNode( deep ) );
			
			/*
			// Need to break the association w/ original kids
			newnode.previousSibling = null;
			newnode.nextSibling     = null;
			newnode.isFirstChild( false );
			*/
			
			return newnode;
	    }
	}
}