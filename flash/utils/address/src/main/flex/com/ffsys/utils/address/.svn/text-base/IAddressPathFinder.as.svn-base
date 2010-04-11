package com.ffsys.utils.address {
	
	import com.ffsys.core.IStrictMode;
	
	/**
	*	Describes the methods available for instances
	*	that provide find routines based on
	*	an <code>IAddressPath</code> and <code>target</code>.
	*	
	*	By default the find operations attempt to use
	*	public property lookup to find the corresponding
	*	instance.
	*	
	*	If you specify <code>methodName</code> the find
	*	routines will attempt to call <code>methodName</code>
	*	on the current target instance passing the path
	*	element that would be used for property lookup as
	*	the sole parameter to the method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.12.2007
	*/
	public interface IAddressPathFinder
		extends IStrictMode {
		
	/*
	*	Attempts to perform public property lookup from
	*	a root target Object using the path elements of this
	*	IAddressPath.
	*	
	*	If a method name is specified then the find
	*	attempt will try to call the specified method on each target
	*	Object as it processes the path elements. By default this
	*	method returns null if a match is not found on any path
	*	element. If this IAddressPath is running in strict mode
	*	a runtime error is thrown as soon as a lookup fails.
	*/
		
		/**
		*	Finds a target instance that is represented
		*	by an <code>IAddressPath</code>.
		*	
		*	By default public property lookup is used,
		*	if methodName is specified we will attempt to call the method
		*	specified for each lookup passing the property as the sole argument.	
		*	
		*	@param target The root target instance where the search should begin from.
		*	@param methodName An optional method to call for each element lookup.
		*/		
		function find(
			target:Object,
			methodName:String = null ):Object;
			
		/**
		*	Finds the instances that correspond to all the elements
		*	of an <code>IAddressPath</code>.
		*	
		*	@param target The <code>target</code> to start the find operation from.
		*	@param methodName An optional <code>methodName</code> to call during the find operation.
		*	
		*	@return An <code>Array</code> of instances found.
		*/
		function findPathElements(
			target:Object,
			methodName:String = null ):Array;			
			
		/**
		*	Finds an <code>Object</code> instance that corresponds to a path
		*	element of an <code>IAddressPath</code> instance.
		*	
		*	@param target The <code>target</code> to start the
		*	find operation from.
		*	@param methodName An optional <code>methodName</code>
		*	to call during the find operation.
		*	
		*	@return The instance found.
		*/
		function findPathElement(
			target:Object,
			element:String,
			methodName:String ):Object;			
	}
}