package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObject;
	import com.ffsys.ui.containers.IContainer;
	
	/**
	*	Describes the contract for documents that encapsulate
	*	a view rendered from an xml definition document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public interface IDocument extends IContainer {
		
		/**
		* 	Attempts to retrieve the lowest document in the
		* 	component hierarchy.
		* 
		* 	If there is no other document in the parent hierarchy
		* 	of this component this document is returned.
		* 
		* 	@return The root document component of this hierarchy.
		*/
		function getRootDocument():IDocument;
		
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
	}
}