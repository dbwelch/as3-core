package com.ffsys.events {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for instances that maintain
	*	a reference to a target <code>IEventDispatcher</code>
	*	instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface ITargetDispatcher {
		
		/**
		*	A target <code>IEventDispatcher</code> instance.
		*/
		function set targetDispatcher( val:IEventDispatcher ):void;
		function get targetDispatcher():IEventDispatcher;
	}
}