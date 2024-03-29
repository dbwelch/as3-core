package org.w3c.dom
{
	/**
	* 	Represents an entity.
	* 
	* 	<p>This interface represents a known entity,
	* 	either parsed or unparsed, in an XML document.
	* 	Note that this models the entity itself not
	* 	the entity declaration.</p>
	*
	*	<p>The nodeName attribute that is inherited from
	* 	Node contains the name of the entity.</p>
	*
	*	<p>An XML processor may choose to completely expand
	* 	entities before the structure model is passed to the DOM;
	* 	in this case there will be no EntityReference nodes
	* 	in the document tree.</p>
	*
	*	<p>XML does not mandate that a non-validating XML processor
	* 	read and process entity declarations made in the external
	* 	subset or declared in parameter entities. This means that
	* 	parsed entities declared in the external subset need not
	* 	be expanded by some classes of applications, and that the
	* 	replacement text of the entity may not be available. When
	* 	the replacement text is available, the corresponding Entity
	* 	node's child list represents the structure of that
	* 	replacement value. Otherwise, the child list is empty.</p>
	*
	*	<p>DOM Level 3 does not support editing Entity nodes;
	* 	if a user wants to make changes to the contents of an Entity,
	* 	every related EntityReference node has to be replaced in the
	* 	structure model by a clone of the Entity's contents, and then
	* 	the desired changes must be made to each of those clones
	* 	instead. Entity nodes and all their descendants are readonly.</p>
	*
	*	<p>An Entity node does not have any parent.</p>
	*
	*	<p><strong>Note:</strong> If the entity contains an unbound namespace prefix,
	* 	the namespaceURI of the corresponding node in the Entity
	* 	node subtree is null. The same is true for EntityReference
	* 	nodes that refer to this entity, when they are created
	* 	using the createEntityReference method of the Document interface.</p>
	*/
	public interface Entity extends Node
	{
		/**
		* 	The public identifier associated with the entity
		* 	if specified, and null otherwise.
		*/
		function get publicId():String;
		
		/**
		* 	The system identifier associated with the entity
		* 	if specified, and null otherwise.
		* 
		* 	This may be an absolute URI or not.
		*/
		function set systemId( value:String ):void;
		
		/**
		* 	For unparsed entities, the name of the
		* 	notation for the entity. For parsed entities,
		* 	this is null.
		*/
		function get notationName():String;
		
		/**
		* 	An attribute specifying the encoding used
		* 	for this entity at the time of parsing,
		* 	when it is an external parsed entity. This is
		* 	null if it an entity from the internal
		* 	subset or if it is not known.
		* 
		* 	@since DOM Level 3
		*/
		function get inputEncoding():String;
		
		/**
		* 	An attribute specifying, as part of the
		* 	text declaration, the encoding of this entity,
		* 	when it is an external parsed entity.
		* 	This is null otherwise.
		* 
		* 	@since DOM Level 3
		*/
		function get xmlEncoding():String;
		
		/**
		* 	An attribute specifying, as part of the text
		* 	declaration, the version number of this entity,
		* 	when it is an external parsed entity.
		* 	This is null otherwise.
		* 
		* 	@since DOM Level 3
		*/
		function get xmlVersion():String;
	}
}