package com.ffsys.events {
	
	/**
	*	Describes the contract for instances that maintain
	*	a reference to an <code>IEventTable</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IEventTableReference {
		
		/**
		*	The <code>IEventTable</code> containing
		*	mappings between event types and listener methods.
		*/
		function set eventTable( val:IEventTable ):void;
		function get eventTable():IEventTable;
	}
}