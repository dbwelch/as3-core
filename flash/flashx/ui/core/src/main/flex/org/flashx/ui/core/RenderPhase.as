package org.flashx.ui.core {
	
	/**
	*	Encapsulates constants that represent the render
	*	phases for components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.07.2010
	*/
	public class RenderPhase {
		
		/**
		*	Invalidates all rendering phases.	
		*/
		public static const ALL:String = "renderAll";
		
		/**
		*	Forces a redraw of a component at it's current
		*	preferred dimensions.	
		*/
		public static const REDRAW:String = "renderRedraw";

		/**
		*	Forces a component to be drawn to the specified
		*	size.
		*/
		public static const SIZE:String = "renderSize";
	}
}