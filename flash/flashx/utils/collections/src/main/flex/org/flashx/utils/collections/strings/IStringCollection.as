package org.flashx.utils.collections.strings {
	
	import org.flashx.utils.collections.data.IDataCollection;
	
	/**
	*	Common type for collections of Strings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	public interface IStringCollection
		extends IDataCollection,
				IStringAccess {
					
		/**
		*	Attempts to find a string by identifier but does
		*	not look in child collections unless the list parameter
		*	is specified and does not throw a runtime exception if no
		*	string could be located.
		*	
		*	@param id The identifier for the string.
		*	@param list The identifier of a specific child string collection
		*	to look in.
		*	
		*	@return The string if found otherwise null.
		*/
		function findStringById(
			id:String, list:String ):String;
					
		
		/**
		*		
		*/
		function getStringCollectionById( id:String ):IStringCollection;
	}
}