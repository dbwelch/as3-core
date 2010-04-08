package com.ffsys.utils.font {
	
	/**
	*	Describes the contract for instances
	*	that represent a collection of type face
	*	styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson 
	*	@since  15.05.2008
	*/
	public interface ITypeFaceStyles {
		
		/**
		*	The total number of styles in this
		*	collection.
		*	
		*	@return The number of styles.	
		*/
		function getLength():int
		
		/**
		*	Gets a type face style at a given index.
		*	
		*	@param index The index to retrieve the style
		*	from.
		*	
		*	@return The style at the given index or null
		*	if no style could be found.
		*/
		function getStyleAt( index:int ):ITypeFaceStyle;
		
		/**
		*	Gets a type face style based on
		*	the string identifier.
		*	
		*	@param id The identifier for the style.
		*	
		*	@return The type face style or null
		*	if no style could be found.	
		*/
		function getStyleById( id:String ):ITypeFaceStyle;
		
		/**
		*	The font to use for all styles in this collection.	
		*/
		function set font( val:String ):void;
		function get font():String;
	}
}