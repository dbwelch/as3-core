package com.ffsys.ui.core {
	
	import flash.display.Stage;
	import flash.events.IEventDispatcher;	
	
	/**
	*	Describes the contract for component
	*	renderer implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.07.2010
	*/
	public interface IComponentRenderer extends IEventDispatcher {
		
		/**
		*	Invalidates a component for a particular phase.	
		*	
		*	@param component The component renderer to be invoked
		*	when the render event is received from the stage.
		*/
		function invalidate(
			renderer:IComponentRender ):void;
			
		/**
		*	The stage that this renderer is using for
		*	invalidation routines.
		*/
		function get stage():Stage;
	}
}