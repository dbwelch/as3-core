package org.flashx.utils.assert {
	
	import org.flashx.errors.AbstractError;
	
	/**
	*	<code>Error</code> messages thrown
	*	when an <code>Assertion</code> fails.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public class AssertionError extends AbstractError {
		
		/**
		*	Error message thrown when an attempt to assert
		*	an expression as true fails.	
		*/
		static public const ASSERT_TRUE:String =
			"Assertion.assertTrue, expected true but was '%s'";
		
		/**
		*	Error message thrown when an attempt to assert
		*	an expression as false fails.	
		*/			
		static public const ASSERT_FALSE:String =
			"Assertion.assertFalse, expected false but was '%s'";
		
		/**
		*	Error message thrown when an attempt to assert
		*	an expression as not null fails.	
		*/			
		static public const ASSERT_NOT_NULL:String =
			"Assertion.assertNotNull, expected Object but was null";
		
		/**
		*	Error message thrown when an attempt to assert
		*	an expression as null fails.	
		*/		
		static public const ASSERT_NULL:String =
			"Assertion.assertNull, expected null but was '%s'";
			
		/**
		*	Error message thrown when an attempt to assert
		*	two expressions as equals fails.
		*/		
		static public const ASSERT_EQUALS:String =
			"Assertion.assertEquals, expected '%s' but was '%s'";
		
		/**
		*	Error message thrown when an attempt to assert
		*	two expressions as not equal fails.
		*/			
		static public const ASSERT_NOT_EQUALS:String =
			"Assertion.assertNotEquals, found equal values '%s'";
			
		/**
		*	Error message thrown when an attempt to assert
		*	two expressions as strictly equals fails.
		*/		
		static public const ASSERT_STRICT_EQUALS:String =
			"Assertion.assertStrictEquals, expected '%s' but was '%s'";
			
		/**
		*	Error message thrown when an attempt to assert
		*	two expressions as strictly not equal fails.
		*/		
		static public const ASSERT_STRICT_NOT_EQUALS:String =
			"Assertion.assertStrictNotEquals, found equal values '%s'";
		
		/**
		*	Error message thrown when an attempt to assert
		*	an <code>Error</code> is of a given
		*	<code>Class</code> fails.
		*/			
		static public const ASSERT_ERROR:String =
			"Assertion.assertError, found no Error instance or Error is not '%s'";
		
		/**
		*	Creates an <code>AssertionError</code> instance.
		*	
		*	@param message The message for the error.
		*	@param ...args Any <code>String</code> replacements
		*	for the <code>message</code>.
		*/
		public function AssertionError( message:String = "", ...args )
		{
			super( message, args );
		}
	}
}