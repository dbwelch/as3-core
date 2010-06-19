package com.ffsys.ui.layout {
	
	/**
	*	Describes the contract for a component that
	*	is aware of margin values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IMarginAware {
		
		/**
		*	The margin associated with this instance.
		*/
		function get margin():IMargin;
		function set margin( margin:IMargin ):void;
	}
}