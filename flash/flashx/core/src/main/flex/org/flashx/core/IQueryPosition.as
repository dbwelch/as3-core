package org.flashx.core {
	
	import org.flashx.core.IQueryFirst;
	import org.flashx.core.IQueryLast;
	
	/**
	*	Describes the contract for instances that
	*	can query the current position in a
	*	hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IQueryPosition
		extends IQueryLast,
				IQueryFirst {
					
		/**
		*	The current position in the hierarchy.
		*/
		function get position():int;
	}
}