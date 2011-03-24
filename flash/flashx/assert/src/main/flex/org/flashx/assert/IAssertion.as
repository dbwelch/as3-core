package org.flashx.assert {
	
	import org.flashx.core.IStrictMode;
	
	/**
	*	Describes the contract for Objects that provide
	*	an API for performing assertions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public interface IAssertion
	 	extends IAssertionElement,
				IStrictMode {
		
		/**
		*	Assert an expression is <code>true</code>.
		*	
		*	@param expression The <code>expression</code> to evaluate.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/
		function assertTrue( expression:Object ):Boolean;
		
		/**
		*	Assert an expression is <code>false</code>.
		*	
		*	@param expression The <code>expression</code> to evaluate.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertFalse( expression:Object ):Boolean;
		
		/**
		*	Assert an expression is not <code>null</code>.
		*	
		*	@param expression The <code>expression</code> to evaluate.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertNotNull( expression:Object ):Boolean;
		
		/**
		*	Assert an expression is <code>null</code>.
		*	
		*	@param expression The <code>expression</code> to evaluate.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertNull( expression:Object ):Boolean;
		
		/**
		*	Assert two instances are equal.
		*	
		*	@param expected The <code>expected</code> value.
		*	@param received The <code>received</code> value.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/
		function assertEquals( expected:Object, received:Object ):Boolean;
		
		/**
		*	Assert two instances are not equal.
		*	
		*	@param expected The <code>expected</code> value.
		*	@param received The <code>received</code> value.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertNotEquals( expected:Object, received:Object ):Boolean;
		
		/**
		*	Assert two instances are equal
		*	using strict comparison.
		*	
		*	@param expected The <code>expected</code> value.
		*	@param received The <code>received</code> value.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertStrictEquals( expected:Object, received:Object ):Boolean;
		
		/**
		*	Assert two instances are not equal
		*	using strict comparison.
		*	
		*	@param expected The <code>expected</code> value.
		*	@param received The <code>received</code> value.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/		
		function assertStrictNotEquals( expected:Object, received:Object ):Boolean;
		
		/**
		*	Assert a thrown <code>Error</code> is of
		*	a certain <code>Class</code>.
		*	
		*	@param error The <code>Error</code> thrown.
		*	@param errorClass The <code>Class</code> the
		*	<code>error</code> should be of.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the assertion passed.
		*/
		function assertError( error:Error, errorClass:Class ):Boolean;	
	}	
}