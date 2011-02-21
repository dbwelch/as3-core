package org.w3c.dom
{
	
	/**
	* 	Represents the type of a document.
	*/
	public interface DocumentType extends Node
	{
		/**
		* 	The name of this document type.
		*/
		function get name():String;
		
		/**
		* 	Document type entities.
		*/
		function get entities():NamedNodeMap;
		
		/**
		* 	Document type notations.
		*/
		function get notations():NamedNodeMap;
		
		/**
		* 	The public identifier for this document type.
		*/
		function get publicId():String;
		
		/**
		* 	The system identifier for this document type.
		*/
		function get systemId():String;
		
		/**
		* 	An internal subset for this document type.
		*/		
		function get internalSubset():String;
	}
}