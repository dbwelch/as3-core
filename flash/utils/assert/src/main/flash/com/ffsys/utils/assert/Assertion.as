package com.ffsys.utils.assert {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.core.IStrictMode;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Lightweight utility class for performing
	*	unit test assertions at runtime.
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
		*	@inheritDoc	
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
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		
		/**
		*	@private
		*/
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			output.totalPasses = totalPasses;
			output.totalFailures = totalFailures;
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputComposites():Array
		{
			return passes.concat( failures );
		}

		/**
		*	@private	
		*/
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		/**
		*	@private	
		*/
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		/**
		*	@private	
		*/
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			var summary:String = total + " assertions, " +
				totalPasses + " passed, " +
				totalFailures + " failed";
			
			output.detail = total;
			output.summary = summary;
			
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		/**
		*	@private	
		*/		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code> representation
		*	of this instance.
		*/
		override public function toString():String
		{
			return getObjectString( true );
		}			
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
