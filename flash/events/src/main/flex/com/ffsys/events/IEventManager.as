package com.ffsys.events {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for instances that manage
	*	adding and removing collections of events from
	*	a target <code>IEventDispatcher</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IEventManager
		extends	IEventElement,
				ITargetDispatcher,
				IControlListeners,
				IControlNotifierListeners,
				IEventFiltersReference {
	}
}