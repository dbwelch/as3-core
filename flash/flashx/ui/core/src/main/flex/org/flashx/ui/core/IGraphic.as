package org.flashx.ui.core {
	
	import org.flashx.ui.core.IInteractiveComponent;
	import org.flashx.ui.graphics.IComponentDraw;
	
	/**
	*	Describes the contract for components
	*	that encapsulate a single graphic and
	*	add interactive functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IGraphic
		extends IInteractiveComponent,
		 		IComponentDraw {
	}
}