package com.ffsys.utils.font {
	
	import com.ffsys.errors.AbstractError;
	
	/**
	*	Encapsulates errors thrown by the 
	*	font management library.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.05.2008
	*/
	public class TypeFaceError extends AbstractError {
		
		/**
		*	Error thrown if an attempt to load the
		*	XML document is performed when no locale
		*	information has been associated with the
		*	font manager.	
		*/
		static public const INVALID_LOCALE:String =
			"Invalid locale data, either locale is null or locale.lang is null.";
		
		/**
		*	Error thrown when the font definition XML document
		*	could not be found.
		*/
		static public const DEFINITION_RESOURCE_NOT_FOUND:String =
			"The font definition XML document '%s' could not be found.";
			
		/**
		*	Error thrown when a font library
		*	could not be found.
		*/
		static public const LIBRARY_RESOURCE_NOT_FOUND:String =
			"The font library '%s' could not be found.";
		
		/**
		*	Creates a <code>TypeFaceError</code> instance.
		*	
		*	@param message The message for the error.
		*	@param ...args Optional values to replace in the
		*	message.
		*/
		public function TypeFaceError( message:String, ...args )
		{
			super( message, args );
		}
	}
}