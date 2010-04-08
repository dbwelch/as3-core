package com.ffsys.events {
	
	/**
	*	Describes the contract for instances that maintain
	*	a reference to an <code>IEventFilters</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IEventFiltersReference {
		
		/**
		*	An <code>IEventFilters</code> implementation
		*	associated with this instance.	
		*/
		function set eventFilters( val:IEventFilters ):void;
		function get eventFilters():IEventFilters;
	}
}