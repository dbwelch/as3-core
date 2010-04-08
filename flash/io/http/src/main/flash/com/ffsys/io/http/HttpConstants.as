package com.ffsys.io.http {
	
	/**
	*	Encapsulates constants common to the http
	*	package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.02.2008
	*/
	public class HttpConstants extends Object {
		
		static public const CONTENT_LENGTH:String =
			"Content-Length";
		
		/**
		*	The delimiter used to differentiate the
		*	header <code>name</code> from the
		*	header <code>value</code>.
		*/
		static public const DELIMITER:String = ":";
		
		/**
		*	@private	
		*/
		public function HttpConstants()
		{
			super();
		}
		
	}	
}