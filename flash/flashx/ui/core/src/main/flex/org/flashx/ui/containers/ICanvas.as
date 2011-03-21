package org.flashx.ui.containers {
	
	import org.flashx.ui.core.IMaskComponent;
	
	/**
	*	Describes the contract for canvas containers which
	*	add mask and scroll support.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public interface ICanvas extends IContainer {
		
		/**
		*	Gets the component used as a mask.	
		*/
		function get masker():IMaskComponent;
		
		/**
		*	Determines whether this canvas' contents are clipped.
		*	
		*	When this canvas is clipped a mask is applied
		*	to this container at the preferred width and height.
		*/
		function get clipped():Boolean;
		function set clipped( clipped:Boolean ):void;
		
		/**
		*	A scroller implementation representing
		*	any scroll bars associated with this canvas.
		*/
		//function get scroller():IScroller;
		//function set scroller( scroller:IScroller ):void;		
	}
}