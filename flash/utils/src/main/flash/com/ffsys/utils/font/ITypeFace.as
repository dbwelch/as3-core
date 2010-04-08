package com.ffsys.utils.font {
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for individual
	*	type faces.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.05.2008
	*/
	public interface ITypeFace
		extends IStringIdentifier {
		
		/**
		*	The styles associated with this type face.
		*/
		function set styles( val:ITypeFaceStyles ):void;
		function get styles():ITypeFaceStyles;
		
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
	}
}