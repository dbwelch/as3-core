package com.ffsys.swat.configuration {
	
	/**
	*	Describes the contract for implementations that
	*	represent default settings for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	public interface IDefaults {
		
		/**
		*	A set of default properties to apply to
		*	textfields when they are created.	
		*/
		function get textfield():Object;
		function set textfield( textfield:Object ):void;
		
		/**
		*	A set of default properties to apply to
		*	textformats when textfields are created.
		*/		
		function get textformat():Object;
		function set textformat( textformat:Object ):void;
	}
}