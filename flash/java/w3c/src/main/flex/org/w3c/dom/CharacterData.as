package org.w3c.dom
{
	
	/**
	* 	Represents character data.
	* 
	* 	The CharacterData interface extends Node
	* 	with a set of attributes and methods for
	* 	accessing character data in the DOM.
	* 
	* 	For clarity this set is defined here rather
	* 	than on each object that uses these attributes
	* 	and methods. No DOM objects correspond
	* 	directly to CharacterData, though Text and
	* 	others do inherit the interface from it.
	* 	All offsets in this interface start from 0.
	*
	*	As explained in the DOMString interface,
	* 	text strings in the DOM are represented
	* 	in UTF-16, i.e. as a sequence of 16-bit units.
	* 	In the following, the term 16-bit units is used
	* 	whenever necessary to indicate that indexing on
	* 	CharacterData is done in 16-bit units.
	*/
	public interface CharacterData extends Node
	{
		/**
		* 	The character data of the node that implements
		* 	this interface.
		* 	
		* 	The DOM implementation may not put arbitrary
		* 	limits on the amount of data that
		* 	may be stored in a CharacterData node. However,
		* 	implementation limits may mean that the entirety
		* 	of a node's data may not fit into a single DOMString.
		* 	In such cases, the user may call substringData to
		* 	retrieve the data in appropriately sized pieces.
		*/
		function get data():String;
		function set data( value:String ):void;
		
		/**
		* 	The number of 16-bit units that are
		* 	available through data and the substringData
		* 	method below. This may have the value zero,
		* 	i.e., CharacterData nodes may be empty.
		*/
		function get length():uint;
		
		/**
		* 	Extracts a range of data from the node.
		* 
		* 	@param offset Start offset of the substring to extract.
		* 	@param count The number of 16-bit units to extract.
		* 
		* 	@throws DOMException INDEX_SIZE_ERR: Raised if the specified
		* 	offset is negative or greater than the number of 16-bit
		* 	units in data, or if the specified count is negative. 
		*	@throws DOMException DOMSTRING_SIZE_ERR: Raised if the
		* 	specified range of text does not fit into a DOMString.
		* 
		* 	@return The specified substring. If the sum of offset and
		* 	count exceeds the length, then all 16-bit units to the
		* 	end of the data are returned.
		*/
		function substringData( offset:Number, count:Number ):String;
		
		/**
		* 	Append the string to the end of the character
		* 	data of the node. Upon success, data provides
		* 	access to the concatenation of data and
		* 	the DOMString specified.
		* 
		* 	@param value The DOMString to append.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this node is readonly.
		*/
		function appendData( value:String ):void;
		
		/**
		* 	Insert a string at the specified 16-bit unit offset.
		* 
		* 	@param offset The character offset at which to insert.
		* 	@param value The DOMString to insert.
		* 
		* 	@throws DOMException INDEX_SIZE_ERR: Raised
		* 	if the specified offset is negative o
		* 	greater than the number of 16-bit units in data.
		* 
		*	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly.
		*/
		function insertData( offset:Number, value:String ):void;
		
		/**
		* 	Remove a range of 16-bit units from the node.
		* 	Upon success, data and length reflect the change.
		* 
		* 	@param offset The offset from which to start removing.
		* 	@param count The number of 16-bit units to delete.
		* 	If the sum of offset and count exceeds length
		* 	then all 16-bit units from offset to the end of
		* 	the data are deleted.
		* 
		* 	@throws DOMException INDEX_SIZE_ERR: Raised if
		* 	the specified offset is negative or greater
		* 	than the number of 16-bit units in data,
		* 	or if the specified count is negative. 
		* 
		*	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly.
		*/
		function deleteData( offset:Number, count:Number ):void;
		
		/**
		* 	Replace the characters starting at the specified
		* 	16-bit unit offset with the specified string.
		* 
		* 	@param offset The offset from which to start replacing.
		* 	@param count The number of 16-bit units to replace.
		* 	If the sum of offset and count exceeds length,
		* 	then all 16-bit units to the end of the data are
		* 	replaced; (i.e., the effect is the same as a
		* 	remove method call with the same range,
		* 	followed by an append method invocation).
		* 	@param value The DOMString with which the range must be replaced.
		* 
		* 	@throws DOMException INDEX_SIZE_ERR: Raised if the
		* 	specified offset is negative or greater than
		* 	the number of 16-bit units in data, or if the
		* 	specified count is negative. 
		* 
		*	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly.
		*/
		function replaceData(
			offset:Number, count:Number, value:String ):void;
	}
}