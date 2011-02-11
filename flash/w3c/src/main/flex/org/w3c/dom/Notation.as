package org.w3c.dom
{
	/**
	* 	Represents a notation.
	* 
	* 	This interface represents a notation declared
	* 	in the DTD. A notation either declares, by name,
	* 	the format of an unparsed entity (see section 4.7
	* 	of the XML 1.0 specification [XML 1.0]), or is used
	* 	for formal declaration of processing instruction targets
	* 	(see section 2.6 of the XML 1.0 specification [XML 1.0]).
	* 
	* 	The nodeName attribute inherited from Node is set
	* 	to the declared name of the notation.
	*
	*	The DOM Core does not support editing Notation nodes;
	* 	they are therefore readonly.
	*
	*	A Notation node does not have any parent.
	*/
	public interface Notation extends Node
	{
		/**
		* 	The public identifier of this notation.
		* 
		* 	If the public identifier was not specified, this is null.
		*/
		function get publicId():String;
		
		/**
		* 	The system identifier of this notation
		* 
		* 	If the system identifier was not specified, this is null.
		* 
		* 	This may be an absolute URI or not.
		*/
		function get systemId():String;
	}
}