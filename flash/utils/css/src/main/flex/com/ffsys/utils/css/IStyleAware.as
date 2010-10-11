package com.ffsys.utils.css {
	
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
	}
}