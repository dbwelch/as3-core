package org.flashx.ui.common {
	
	/**
	*	Describes the contract for objects that are aware
	*	of styles associated with them.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public interface IStyleAware {
		
		/**
		*	The space delimited list of styles to apply.
		*/
		function get styles():String;
		function set styles( styles:String ):void;
		
		/**
		*	Invoked to apply the styles associated with
		*	this style aware implementation.
		* 
		* 	@return An array of the style objects that
		* 	were applied.
		*/
		function applyStyles():Array;
		
		/**
		* 	Gets the css class level string identifiers.
		* 
		* 	@return The class level identifiers.
		*/
		function getClassLevelStyleNames():Vector.<String>;
	}
}