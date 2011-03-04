/**
*	A lightweight assertion library designed to allow for assertions to be executed during
*	integration tests for an application.
*
*	You can use conditional compilation to place assertions in the code base for an application
*	and then only compile the assertions into the application during the development phase.
*
*	If you want an overall report of all assertions you should only ever instantiate a single
*	<code>Assertion</code>. When using dependency injection you can configure the assertion instance
*	to be a singleton instance otherwise you could declare the assertion as a static member.
*/
package com.ffsys.utils.assert {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.core.IStrictMode;
	
	/**
	*	Lightweight utility class for performing
	*	unit test assertions at runtime.
	* 
	* 	<pre>
	*	var assertion:IAssertion = new Assertion();
	*	assertion.assertEquals( "a", "a" );
	*	assertion.assertTrue( true );
	* 	</pre>
	* 
	* 	This class operates in strict mode by default which means a runtime exception will
	* 	be thrown as soon as an assertion fails, to prevent this behaviour you can alter
	* 	the <code>strict</code> property or instantiate the assertion disabling <code>strict</code>
	* 	mode.
	* 
	* 	<pre>
	*	var assertion:IAssertion = new Assertion( false );
	* 	</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public class Assertion extends EventDispatcher
		implements 	IAssertion,
					IAssertionResultStore {
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is <code>true</code>.
		*/
		static public const ASSERT_TRUE_METHOD:String =
			"assertTrue";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is <code>false</code>.	
		*/			
		static public const ASSERT_FALSE_METHOD:String =
			"assertFalse";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is not <code>null</code>.	
		*/		
		static public const ASSERT_NOT_NULL_METHOD:String =
			"assertNotNull";
			
		/**
		*	Constant referring to the method used
		*	to assert an expression is <code>null</code>.
		*/			
		static public const ASSERT_NULL_METHOD:String =
			"assertNull";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is equal to another
		*	expression.	
		*/		
		static public const ASSERT_EQUALS_METHOD:String =
			"assertEquals";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is not equal to another
		*	expression.	
		*/			
		static public const ASSERT_NOT_EQUALS_METHOD:String =
			"assertNotEquals";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is equal to another
		*	expression using strict comparison.	
		*/
		static public const ASSERT_STRICT_EQUALS_METHOD:String =
			"assertStrictEquals";
		
		/**
		*	Constant referring to the method used
		*	to assert an expression is not equal to another
		*	expression using strict comparison.
		*/			
		static public const ASSERT_STRICT_NOT_EQUALS_METHOD:String =
			"assertStrictNotEquals";
		
		/**
		*	Constant referring to the method used
		*	to assert a runtime error thrown is of
		*	the correct <code>Class</code>.
		*/		
		static public const ASSERT_ERROR_METHOD:String =
			"assertError";
		
		/**
		*	@private	
		*/	
		protected var _strict:Boolean;
			
		/**
		*	@private	
		*/
		protected var _passes:Array;
		
		/**
		*	@private	
		*/
		protected var _failures:Array;
		
		/**
		*	Creates an <code>Assertion</code> instance.	
		*	
		*	@param strict Determines whether this instance
		*	operates in a <code>strict</code> manner.
		*/
		public function Assertion(
			strict:Boolean = true )
		{
			super();
			this.strict = strict;
			
			_passes = new Array();
			_failures = new Array();
		}
		
		/*
		*	IAssertionResultStore implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/		
		public function get total():int
		{
			return ( passes.length + failures.length );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get totalPasses():int
		{
			return passes.length;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get totalFailures():int
		{
			return failures.length;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get passes():Array
		{
			return _passes;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get failures():Array
		{
			return _failures;
		}
		
		/*
		*	IStrictMode implementation.	
		*/
		
		/**
		*	Determines whether this assertion operates in strict mode.
		* 
		* 	When an assertion is running in strict mode a runtime exception
		* 	is thrown as soon as an assertion fails.
		*/
		public function set strict( val:Boolean ):void
		{
			_strict = val;
		}
		
		public function get strict():Boolean
		{
			return _strict;
		}
		
		/*
		*	IAssertion implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/
		public function assertTrue( expression:Object ):Boolean
		{
			var methodName:String = ASSERT_TRUE_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expression === true );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_TRUE, expression );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);
			
			return result;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertFalse( expression:Object ):Boolean
		{
			var methodName:String = ASSERT_FALSE_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expression === false );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_FALSE, expression );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);		
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertNotNull( expression:Object ):Boolean
		{
			var methodName:String = ASSERT_NOT_NULL_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expression != null );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_NOT_NULL, expression );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertNull( expression:Object ):Boolean
		{
			var methodName:String = ASSERT_NULL_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expression == null );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_NULL, expression );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);		
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertEquals( expected:Object, received:Object ):Boolean
		{
			var methodName:String = ASSERT_EQUALS_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expected == received );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_EQUALS, expected, received );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);			
			
			return result;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertNotEquals( expected:Object, received:Object ):Boolean
		{
			var methodName:String = ASSERT_NOT_EQUALS_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expected != received );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_NOT_EQUALS, expected, received );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);		
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertStrictEquals( expected:Object, received:Object ):Boolean
		{
			var methodName:String = ASSERT_STRICT_EQUALS_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expected === received );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_STRICT_EQUALS, expected, received );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);	
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertStrictNotEquals( expected:Object, received:Object ):Boolean
		{
			var methodName:String = ASSERT_STRICT_NOT_EQUALS_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean = ( expected !== received );
			
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_STRICT_NOT_EQUALS, expected, received );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);		
			
			return result;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function assertError( error:Error, errorClass:Class ):Boolean
		{
			var methodName:String = ASSERT_ERROR_METHOD;
			var assertionError:AssertionError = null;
			
			var result:Boolean =
				( error is errorClass );
				
			if( !result )
			{
				assertionError = new AssertionError(
					AssertionError.ASSERT_ERROR, errorClass );
			}
			
			handleResult(
				result,
				methodName,
				arguments,
				assertionError
			);			
			
			return result;			
		}
		
		/**
		*	@private	
		*/
		protected function handleResult(
			result:Boolean,
			methodName:String,
			parameters:Array,
			error:AssertionError = null ):void
		{
				
			if( result )
			{
				var pass:IAssertionPass =
					new AssertionPass( methodName, parameters );
				
				_passes.push( pass );
				
				AssertionEvent.dispatchAssertionPass( this, pass );
			}else{
				
				if( !error )
				{
					throw new Error(
						"Assertion, a failed assertion must have an associated AssertionError instance" );
				}
				
				var fail:IAssertionFail =
					new AssertionFail( methodName, parameters );
				fail.error = error;
				
				_failures.push( fail );
				
				AssertionEvent.dispatchAssertionFail( this, fail );
				
				if( strict )
				{
					throw error;
				}
				
			}
		}
	}
}