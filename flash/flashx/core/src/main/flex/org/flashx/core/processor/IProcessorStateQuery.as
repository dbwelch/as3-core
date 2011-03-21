package org.flashx.core.processor {
	
	import org.flashx.core.IQueryPosition;
	
	/**
	*	Describes the contract for instances that
	*	provide an interface for querying 
	*	the state of a processor pass.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.09.2007
	*/
	public interface IProcessorStateQuery
		extends IQueryPosition {
			
		/**
		*	Determines whether the current processing
		*	pass has finished.	
		*	
		*	@return A <code>Boolean</code> indicating
		*	whether the current processing pass has finished.
		*/
		function isFinished():Boolean;
	}
}