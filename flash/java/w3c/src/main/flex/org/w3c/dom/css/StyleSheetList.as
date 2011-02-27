package org.w3c.dom.css
{
	
	/**
	* 	The StyleSheetList interface provides the abstraction
	* 	of an ordered collection of style sheets.
	*
	*	The items in the StyleSheetList are accessible
	* 	via an integral index, starting from 0.
	*/
	public interface StyleSheetList
	{
		/**
		* 	The number of StyleSheets in the list.
		* 
		* 	The range of valid child stylesheet indices
		* 	is 0 to length-1 inclusive.
		*/
		function get length():uint;
		
		/**
		* 	Used to retrieve a style sheet by ordinal index. 
		* 
		* 	If index is greater than or equal to the number of
		* 	style sheets in the list, this returns null.
		* 
		* 	@param index Index into the collection.
		* 
		* 	@return The style sheet at the index position
		* 	in the StyleSheetList, or null if that is
		* 	not a valid index.
		*/
		function item( index:uint ):StyleSheet;
	}
}