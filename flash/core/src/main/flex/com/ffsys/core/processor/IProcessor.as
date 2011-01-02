package com.ffsys.core.processor {
	
	/**
	*	Describes the contract for instances that perform
	*	processing of a hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public interface IProcessor extends IProcessorElement {
		
		/**
		* 	Determines whether this processor is running asynchronously.
		* 
		* 	The default value is <code>true</code>.
		* 
		* 	When a processor is running asynchronously no processing
		* 	continues on to the next processing part until the processor
		* 	is explicitly instructed to do so. Otherwise processing happens
		* 	immediately and one should be able to access the return value
		* 	from invoking the <code>process</code> method.
		*/
		function get async():Boolean;
		function set async( value:Boolean ):void;
		
		
		/**
		* 	A collection of targets encountered during processing.
		*/
		function get targets():Vector.<Object>;
		
		/**
		*	An <code>Array</code> of <code>String</code>
		*	member names to use when performing
		*	<code>Object</code> lookup.
		*/
		function set parameters( val:Array ):void;
		function get parameters():Array;
		
		/**
		*	Starts processing from a given
		*	<code>index</code>.
		*	
		*	@param The <code>index</code> to begin
		*	processing from.
		*/
		function process( index:int = 0 ):*;
		
		/**
		*	Restarts processing on a <code>target</code>
		*	at a given <code>index</code>.
		*	
		*	@param The <code>Object</code> to become the
		*	<code>currentTarget</code>
		*	@param The <code>index</code> to begin
		*	processing from.
		*/
		function restart( target:Object, index:int = 0 ):void;
		
		/**
		*	The <code>property</code> at the current
		*	processor <code>position</code>.
		*/
		function set property( val:String ):void;
		function get property():String;
		
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