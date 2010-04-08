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
	}
}