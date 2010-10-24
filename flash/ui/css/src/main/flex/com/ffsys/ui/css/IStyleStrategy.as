package com.ffsys.ui.css {
	
	import com.ffsys.core.IDestroy;
	
	/**
	*	Describes the contract for objects that represent
	*	a strategy for applying styles to objects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public interface IStyleStrategy 
		extends IDestroy {
		
		/**
		*	The stylesheet being applied by this strategy.	
		*/
		function get styleSheet():ICssStyleCollection;
		function set styleSheet( styleSheet:ICssStyleCollection ):void;
	}
}