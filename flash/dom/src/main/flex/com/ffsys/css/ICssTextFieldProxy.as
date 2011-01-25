package com.ffsys.css {
	
	import flash.text.TextField;
	
	/**
	*	Describes the contract for implementations that proxy
	*	the application of textfield styles to a number of encapsulated
	*	textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface ICssTextFieldProxy {
		
		/**
		*	Gets the list of textfields that
		*	should have text styles applied to them.
		*	
		*	@return The list of encapsulated textfields.
		*/
		function getProxyTextFields():Vector.<TextField>;
	}
}