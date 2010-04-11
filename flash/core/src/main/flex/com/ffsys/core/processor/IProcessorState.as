package com.ffsys.core.processor {
	
	import com.ffsys.core.processor.IProcessor;
	import com.ffsys.core.processor.IProcessorElement;
	
	/**
	*	Describes the contract for instances that
	*	represent the state of a processing pass.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public interface IProcessorState
		extends IProcessorElement {
		
		/**
		*	The <code>IProcessor</code> instance that created
		*	this processing state.
		*/
		function set processor( val:IProcessor ):void;
		function get processor():IProcessor;
	}
}