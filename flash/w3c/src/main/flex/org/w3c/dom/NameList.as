package org.w3c.dom
{
	/**
	* 	Represents a collection of namespaces.
	* 
	* 	The NameList interface provides the 
	* 	abstraction of an ordered collection of
	* 	parallel pairs of name and namespace
	* 	values (which could be null values),
	* 	without defining or constraining how
	* 	this collection is implemented.
	* 	
	* 	The items in the NameList are accessible
	* 	via an integral index, starting from 0.
	*/
	public interface NameList
	{
		/**
		* 	The number of pairs (name and namespaceURI)
		* 	in the list. The range of valid child
		* 	node indices is 0 to length-1 inclusive.
		*/
		function get length():uint;
		
		/**
		* 	Returns the indexth name item in the collection.
		* 
		* 	@param index Index into the collection.
		* 
		* 	@return The name at the indexth position in
		* 	the NameList, or null if there is no name
		* 	for the specified index or if the index
		* 	is out of range.
		*/
		function getName( index:int ):String;
		
		/**
		* 	Returns the indexth namespaceURI item in the collection.
		* 
		* 	@param index Index into the collection.
		* 
		* 	@return The namespace URI at the indexth position
		* 	in the NameList, or null if there is no name
		* 	for the specified index or if the index is out of range.
		*/
		function getNamespaceURI( index:int ):String;
		
		/**
		* 	Test if a name is part of this NameList.
		* 
		* 	@param name The name to look for.
		* 
		* 	@return true if the name has been found, false otherwise.
		*/
		function contains( name:String ):Boolean;
		
		/**
		* 	Test if the pair namespaceURI/name is part
		* 	of this NameList.
		* 
		* 	@param namespaceURI The namespace URI to look for.
		* 	@param name The name to look for.
		* 
		* 	@return true if the pair namespaceURI/name
		* 	has been found, false otherwise.
		*/
		function containsNS(
			namespaceURI:String,
			name:String ):Boolean;
	}
}