package com.ffsys.utils.font {
	
	/**
	*	Describes the contract for instances
	*	that encapsulate a group of fonts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.05.2008
	*/
	public interface ITypeFaceGroup {
		
		/**
		*	The ISO 639-1 language code which determines
		*	which locale this group of fonts is associated
		*	with.
		*	
		*	@see com.ffsys.utils.locale.ILocale
		*	@see com.ffsys.utils.locale.Locale
		*/
		function set lang( val:String ):void;
		function get lang():String;
		
		/**
		*	Gets the number of type faces in this group.
		*	
		*	@return The total number of type faces in this
		*	group.
		*/
		function getLength():int;
		
		/**
		*	Gets a type face at a given index.
		*	
		*	@param index The index to retrieve the type face
		*	from.
		*	
		*	@return The type face at the given index or
		*	null if the index is out of bounds.	
		*/
		function getTypeFaceAt( index:int ):ITypeFace;
		
		/**
		*	Gets a style by identifier optionally looking
		*	for the style in a particular type face.
		*	
		*	@param id The identifier for the style.
		*	@param typeFaceId The identifier for a particular
		*	type face that the style should be extracted from.
		*	
		*	@return The type face style if found otherwise null.	
		*/
		function getStyleById(
			id:String, typeFaceId:String = null ):ITypeFaceStyle;
			
			
		/**
		*	Gets a type face by identifier.
		*	
		*	@param id The identifier for the type face.
		*	
		*	@return The retrieved type face or null if
		*	none could be found.
		*/
		function getTypeFaceById( id:String ):ITypeFace;
		
		/**
		*	The path to load the swf library
		*	with embedded font outlines from.
		*/
		function set path( val:String ):void;
		function get path():String;
	}
}