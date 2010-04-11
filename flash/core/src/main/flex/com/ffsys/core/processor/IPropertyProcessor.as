package com.ffsys.core.processor {
	
	/**
	*	Describes the contract for instances that perform
	*	processing of a property hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public interface IPropertyProcessor extends IProcessor {
		
		/**
		*	The <code>property</code> at the current
		*	processor <code>position</code>.
		*/
		function set property( val:String ):void;
		function get property():String;
		
		/**
		*	An <code>Array</code> of <code>String</code>
		*	member names to use when performing
		*	<code>Object</code> lookup.
		*/
		function set parameters( val:Array ):void;
		function get parameters():Array;
		
		/**
		*	Reference to the next target
		*	<code>Object</code> in the lookup
		*	hierarchy.
		*/
		function get nextTarget():Object;		
		
		/**
		*	Determines whether <code>currentTarget</code>
		*	has the current <code>property</code>.
		*/
		function hasProperty():Boolean;
	}
}