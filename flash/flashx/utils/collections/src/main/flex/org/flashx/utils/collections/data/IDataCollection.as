package org.flashx.utils.collections.data {
	
	import flash.utils.Dictionary;
	
	import org.flashx.core.IStringIdentifier;
	import org.flashx.utils.locale.ILocale;
	
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
		*	The number of child collections.	
		*/
		function get length():int;
			
		/**
		*	Gets an array of classes that are valid types to be stored
		*	in this collection.
		*/
		function get types():Array;
		
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
		*	An array of the child collections.
		*/
		function get children():Array;	
	
		/**
		*	A dictionary of the properties assigned to this collection.
		*/
		function get data():Dictionary;
		
		/**
		*	Merges another data collection into this one.	
		*/
		function merge( collection:IDataCollection ):void;
		
		/**
		*	Gets a child collection by identifier.
		*	
		*	@param id The identifier for the child collection.
		*	
		*	@return The child collection or null if it could not be found.	
		*/
		function getCollectionById( id:String ):IDataCollection;
		
		/**
		*	Removes a child collection by identifier.
		*	
		*	@param id The identifier for the child collection.
		*	
		*	@return The deleted child collection or null if it could not be found.
		*/
		function removeCollectionById( id:String ):IDataCollection;
		
		/**
		*	Adds a child collection by identifier.
		*	
		*	@param id The identifier for the child collection.
		*	@param child The child collection.
		*	
		*	@return Wheter the collection was added, this will be false
		*	if either id or child are null.
		*/
		function addCollection( id:String, child:IDataCollection ):Boolean;			
	}
}