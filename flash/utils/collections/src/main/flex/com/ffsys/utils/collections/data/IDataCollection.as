package com.ffsys.utils.collections.data {
	
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.utils.locale.ILocale;
	
	/**
	*	Describes the contract for collections of data referenced by
	*	string identifiers. These may be collections of strings or
	*	simple types.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.11.2007
	*/
	public interface IDataCollection
		extends IStringIdentifier {
		
		/**
		*	Sets the parent collection for this collection.
		*	
		*	@param collection The parent collection.
		*/
		function set collection( val:IDataCollection ):void;
		
		/**
		*	Gets the parent collection for this collection.
		*	
		*	@return The parent collection or null if there is
		*	no parent for this collection.	
		*/
		function get collection():IDataCollection;
		
		/**
		*	Gets the locale associated with this collection.
		*	
		*	@return A locale associated with this collection or null
		*	if no locale has been assigned.
		*/
		function get locale():ILocale;
		
		/**
		*	Sets a locale associated with this collection.
		*	
		*	@param locale A locale to associate with this collection.
		*/
		function set locale( locale:ILocale ):void;
		
		/**
		*	Gets a child collection by identifier.
		*	
		*	@param id The identifier for the child collection.
		*	
		*	@return The child collection of null if it could not be found.	
		*/
		function getCollectionById( id:String ):IDataCollection;	
	}
}