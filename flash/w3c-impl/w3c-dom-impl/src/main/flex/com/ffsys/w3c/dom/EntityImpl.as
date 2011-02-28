package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	*	Entity nodes hold the reference data for an XML Entity -- either
	*	parsed or unparsed. The nodeName (inherited from Node) will contain
	*	the name (if any) of the Entity. Its data will be contained in the
	*	Entity's children, in exactly the structure which an
	*	EntityReference to this name will present within the document's
	*	body.
	* 
	*	<p>Note that this object models the actual entity, _not_ the entity
	*	declaration or the entity reference.</p>
	* 
	*	<p>An XML processor may choose to completely expand entities before
	*	the structure model is passed to the DOM; in this case, there will
	*	be no EntityReferences in the DOM tree.</p>
	* 
	*	<p>Quoting the 10/01 DOM Proposal,</p>
	* 	
	*	<blockquote>
	*	"The DOM Level 1 does not support editing Entity nodes; if a user
	*	wants to make changes to the contents of an Entity, every related
	*	EntityReference node has to be replaced in the structure model by
	*	a clone of the Entity's contents, and then the desired changes
	*	must be made to each of those clones instead. All the
	*	descendants of an Entity node are readonly."</blockquote>
	* 
	*	<p>I'm interpreting this as: It is the parser's responsibilty to call
	*	the non-DOM operation setReadOnly(true,true) after it constructs
	*	the Entity. Since the DOM explicitly decided not to deal with this,
	*	_any_ answer will involve a non-DOM operation, and this is the
	*	simplest solution.</p>
	* 
	* 	<p><strong>Note:</strong> documentation reproduced from xerces-j.</p>
	*/
	public class EntityImpl extends ParentNode
		implements Entity
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "Entity";
		
		private var _publicId:String;
		private var _systemId:String;
		private var _notationName:String;
		private var _inputEncoding:String;
		private var _xmlEncoding:String;
		private var _xmlVersion:String;
		
		/**
		* 	Creates an <code>EntityImpl</code> instance.
		*/
		public function EntityImpl(
			owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return this.notationName;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.ENTITY_NODE;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get publicId():String
		{
			return _publicId;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set systemId( value:String ):void
		{
			_systemId = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get notationName():String
		{
			return _notationName;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get inputEncoding():String
		{
			return _inputEncoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlEncoding():String
		{
			return _xmlEncoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlVersion():String
		{
			return _xmlVersion;
		}
	}
}