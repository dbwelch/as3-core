package com.ffsys.io.loaders.core {
	
	import com.ffsys.core.IFatal;
	import com.ffsys.core.ISilent;	
	
	/**
	*	Describes the contract for instances that encapsulate
	*	options for <code>ILoader</code> implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface ILoadOptions
		extends IFatal,
		 		ISilent {
			
		/**
		*	Determines whether an <code>id</code> should
		*	automatically be generated for the <code>ILoader</code>
		*	implementation.
		*	
		*	If an <code>id</code> is automatically generated
		*	it will be created from the file name of the loaded
		*	resource and converted to a camel case representation
		*	of the file name with any extension removed.
		*/
		function set autoGenerateId( val:Boolean ):void;
		function get autoGenerateId():Boolean;
		
		/**
		*	Determines whether an <code>ILoaderQueue</code>
		*	implementation should continue loading resources
		*	when a resource not found is encountered.
		*/
		function set continueOnResourceNotFound( val:Boolean ):void;
		function get continueOnResourceNotFound():Boolean;
		
		/**
		*	Determines whether a resource not found event
		*	should be treated quietly. When a resource not
		*	found is treated quietly no event indicating that
		*	a resource not found has occured will be dispatched.
		*	
		*	This should only be used if a resource is completely
		*	optional.
		*/
		function set quietOnResourceNotFound( val:Boolean ):void;
		function get quietOnResourceNotFound():Boolean;
	}
}