package com.ffsys.utils.merge {
	
	/**
	*	Defines the methods and properties for instances that
	*	allow merging of encapsulated data.
	*	
	*	@see com.ffsys.utils.MergeUtils
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Kelvin Luck
	*/
	public interface IMergable
	{
		/**
		*	Merges this <code>IMergable</code> object into
		*	another destination <code>IMergable</code> instance and
		*	returns the merged instance.
		* 
		* 	@param destination The <code>IMergable</code> instance
		*	to merge into.
		*	
		* 	@return The merged instance.
		*/
		function mergeInto( destination:IMergable ):IMergable;
		
		/**
		*	Returns an <code>Array</code> of property names to exclude
		*	when merging this instance. This should be
		* 	used to ensure that merging two <code>IMergable</code>
		*	objects never results in an infinite loop
		*	which can occur if circular references exist.
		*	
		*	@return An <code>Array</code> of the property names
		*	to ignore when merging this instance.
		*/
		function get mergeExcludedProperties():Array;
	}
}