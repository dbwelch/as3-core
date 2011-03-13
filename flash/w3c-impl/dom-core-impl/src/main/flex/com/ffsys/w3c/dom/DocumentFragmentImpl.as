package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	*	Represents a document fragment.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DocumentFragmentImpl extends ParentNode
		implements DocumentFragment
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "DocumentFragment";
		
		/**
		* 	The node name for document fragment nodes.
		*/
		public static const NODE_NAME:String = "#document-fragment";
		
		/**
		* 	Creates a <code>DocumentFragmentImpl</code> instance.
		* 
		* 	@param owner The owner document.
		*/
		public function DocumentFragmentImpl(
			owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.DOCUMENT_FRAGMENT_NODE;
		}
		
		/**
		* 	@private
		* 	
		*	Override default behavior to call normalize() on this Node's
		*	children. It is up to implementors or Node to override normalize()
		* 	to take action.
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
			var next:Node;
	        for( kid = firstChild; kid != null; kid = next )
			{
	            next = kid.nextSibling;
	            // If kid is a text node, we need to check for one of two
	            // conditions:
	            //   1) There is an adjacent text node
	            //   2) There is no adjacent text node, but kid is
	            //      an empty text node.
	            if ( kid.nodeType == NodeType.TEXT_NODE )
	            {
	                // If an adjacent text node, merge it with kid
	                if( next != null
						&& next.nodeType == NodeType.TEXT_NODE )
	                {
	                    ( Text( kid ) ).appendData( next.nodeValue );
	                    removeChild( next );
	                    next = kid; // Don't advance; there might be another.
	                }else
	                {
	                    // If kid is empty, remove it
	                    if( kid.nodeValue == null
							|| kid.nodeValue.length == 0 ) {
	                        removeChild( kid );
	                    }
	                }
	            }
	            kid.normalize();
	        }

	       setIsNormalized( true );
	    }		
	}
}