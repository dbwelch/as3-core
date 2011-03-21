package org.flashx.ui.dom
{
	import flash.display.*;
	
	/**
	*	Describes the contract for implementations that
	* 	form the root of a <code>DOM</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public interface IDomDocument extends IDomElement
	{
		
		function get documentElement():IDocumentBody;
		
		/**
		* 	The binding used to access data associated with the parsing
		* 	of this document.
		*/
		function get binding():Object;
		
		/**
		* 	The object used to store mappings between child identifiers
		* 	and the child element reference.
		*/
		function get identifiers():Object;
		
		/**
		* 	Invoked by the runtime interpreter to inform this document
		* 	that is has been fully prepared from the xml document
		* 	definition.
		* 
		* 	This allows document implementations to implement functionality
		* 	for automatically creating cross references between components
		* 	when a document is prepared.
		*/
		function prepared():void;
		
		
		/**
		* 	@inheritDoc
		*/		
		function getElementsByMatch( re:RegExp ):Vector.<DisplayObject>;
		
		/**
		* 	Attempts to retrieve a child component by identifier.
		* 
		* 	The default implementation of this method first tests
		* 	against and <code>id</code> property before comparing
		* 	against a <code>name</code> property.
		* 
		* 	@param id The identifier for the child component.
		* 
		* 	@return The child component if found otherwise null.
		*/
		function getElementById( id:String ):IDomElement;
	}
}