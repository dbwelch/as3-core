package com.ffsys.utils.font {
	
	import flash.events.IEventDispatcher;
	import flash.text.TextFormat;
	
	import com.ffsys.utils.locale.ILocale;
	
	/**
	*	Describes the contract for instances
	*	that manage runtime fonts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.05.2008
	*/
	public interface ITypeFaceManager
		extends IEventDispatcher {
		
		/**
		*	The <code>ILocale</code> implementation that
		*	determines which set of runtime font libraries
		*	to load.
		*/
		function set locale( val:ILocale ):void;
		function get locale():ILocale;
		
		/**
		*	Gets the array of <code>ITypeFaceGroup</code>
		*	instances encapsulated by this instance.
		*/
		function get groups():Array;
		
		/**
		*	Gets a type face group at a given index.
		*	
		*	@param index The index to retrieve the group
		*	from.
		*	
		*	@return The group at the given index or null
		*	if the index is out of bounds.	
		*/
		function getGroupAt( index:int ):ITypeFaceGroup
		
		/**
		*	The number of groups registered with this
		*	manager.
		*	
		*	@return The total number of type face groups.
		*/
		function getLength():int;
		
		/**
		*	Finds a group based on a given language string.
		*	
		*	@param lang The language code for the group.
		*	
		*	@return The group if found otherwise null.
		*/
		function getGroupByLang( lang:String = null ):ITypeFaceGroup;	
		
		/**
		*	Gets all the paths for the font libraries
		*	associated with a particular group that
		*	has the given language string.
		*	
		*	@param lang The language code for the group
		*	that all paths should be returned from.
		*	
		*	@return An array of the paths to the swf
		*	libraries or an empty array if no group
		*	or type faces could be found.
		*/
		function getPathsByLang( lang:String = null ):Array;
		
		/**
		*	Gets a type face style optionally looking in
		*	a particular type face group and individual
		*	type face.
		*	
		*	@param id The identifier for the type face style.
		*	@param lang The language identifier for the type
		*	face group.
		*	@param typeFaceId The identifier of a particular
		*	type face.
		*	
		*	@return The type face style if found otherwise null.	
		*/
		function getStyleById(
			id:String,
			lang:String = null,
			typeFaceId:String = null ):ITypeFaceStyle;
			
		/**
		*	Gets a type face style cast to a <code>TextFormat</code>
		*	instance. Provided as a convenience method.	
		*	
		*	@param id The identifier for the type face style.
		*	@param lang The language identifier for the type
		*	face group.
		*	@param typeFaceId The identifier of a particular
		*	type face.
		*	
		*	@return The text format if found otherwise null.
		*/	
		function getTextFormatById(
			id:String,
			lang:String = null,
			typeFaceId:String = null ):TextFormat;
		
		/**
		*	Instructs the instance to load the XML
		*	document that defines the fonts available
		*	for the application.
		*	
		*	Once the XML document has been loaded
		*	and deserialized the instance will start
		*	loading all fonts referenced in the
		*	parsed document.
		*/
		function load( path:String ):void;
	}
}