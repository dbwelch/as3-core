package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;
		
	/**
	*	Represents an entity reference.
	* 
	*	<p>EntityReference models the XML &amp;entityname; syntax, when used for
	*	entities defined by the DOM. Entities hardcoded into XML, such as
	*	character entities, should instead have been translated into text
	*	by the code which generated the DOM tree.</p>
	* 
	*	<p>An XML processor has the alternative of fully expanding Entities
	*	into the normal document tree. If it does so, no EntityReference nodes
	*	will appear.</p>
	* 
	*	<p>Similarly, non-validating XML processors are not required to read
	*	or process entity declarations made in the external subset or
	*	declared in external parameter entities. Hence, some applications
	*	may not make the replacement value available for Parsed Entities 
	*	of these types.</p>
	* 
	*	<p>EntityReference behaves as a read-only node, and the children of 
	*	the EntityReference (which reflect those of the Entity, and should
	*	also be read-only) give its replacement value, if any. They are 
	*	supposed to automagically stay in synch if the DocumentType is 
	*	updated with new values for the Entity.</p>
	* 
	*	<p>The defined behavior makes efficient storage difficult for the DOM
	*	implementor. We can't just look aside to the Entity's definition
	*	in the DocumentType since those nodes have the wrong parent (unless
	*	we can come up with a clever "imaginary parent" mechanism). We
	*	must at least appear to clone those children... which raises the
	*	issue of keeping the reference synchronized with its parent.
	*	This leads me back to the "cached image of centrally defined data"
	*	solution, much as I dislike it.</p>
	* 
	*	<p>For now I have decided, since REC-DOM-Level-1-19980818 doesn't
	*	cover this in much detail, that synchronization doesn't have to be
	*	considered while the user is deep in the tree. That is, if you're
	*	looking within one of the EntityReferennce's children and the Entity
	*	changes, you won't be informed; instead, you will continue to access
	*	the same object -- which may or may not still be part of the tree.
	*	This is the same behavior that obtains elsewhere in the DOM if the
	*	subtree you're looking at is deleted from its parent, so it's
	*	acceptable here. (If it really bothers folks, we could set things
	*	up so deleted subtrees are walked and marked invalid, but that's
	*	not part of the DOM's defined behavior.)</p>
	* 
	*	<p>As a result, only the EntityReference itself has to be aware of
	*	changes in the Entity. And it can take advantage of the same
	*	structure-change-monitoring code I implemented to support
	*	DeepNodeList.</p>
	* 
	* 	<p><strong>Note:</strong> documentation reproduced from xerces-j.</p>
	*/
	public class EntityReferenceImpl extends ParentNode
		implements EntityReference
	{
		private var _baseURI:String;
		
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "EntityReference";
				
		/**
		* 	Creates an <code>EntityReferenceImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The name of the entity reference.
		*/
		public function EntityReferenceImpl(
			owner:CoreDocumentImpl = null,
			name:String = null )
		{
			super( owner );
			setInternalNodeName( name );
			setReadOnly( true, false );
			setNeedsSyncChildren( true );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get name():String
		{
			return nodeName;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.ENTITY_REFERENCE_NODE;
		}
	}
}