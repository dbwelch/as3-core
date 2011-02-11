package org.w3c.dom
{
	
	/**
	* 	Represents character data.
	*/
	public interface CharacterData extends Node
	{
		/**
		* 	The number of 16-bit units that are
		* 	available through data and the substringData
		* 	method below. This may have the value zero,
		* 	i.e., CharacterData nodes may be empty.
		*/
		function get length():uint;
		
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
		* 	Appends data to this character data.
		* 
		* 	@param value The data to append.
		*/
		function appendData( value:String ):void;
		
		/**
		* 	Inserts data into this character data.
		* 
		* 	@param offset The offset to insert the data at.
		* 	@param value The data to insert.
		*/
		function insertData( offset:Number, value:String ):void;
		
		/**
		* 	Deletes data from this character data.
		* 
		* 	@param offset The offset for the deletion.
		* 	@param count The number of characters to delete from the data.
		*/
		function deleteData( offset:Number, count:Number ):void;
		
		/**
		* 	Replaces data with updated data.
		* 
		* 	@param offset The offset to replace the data at.
		* 	@param count The number of characters of data to replace.
		* 	@param value The replacement data.
		*/
		function replaceData(
			offset:Number, count:Number, value:String ):void;
	}
}