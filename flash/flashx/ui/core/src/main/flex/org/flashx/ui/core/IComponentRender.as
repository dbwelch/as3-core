package org.flashx.ui.core {
	
	/**
	*	Describes the contract for implementations that
	*	represent a single rendering routine.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.07.2010
	*/
	public interface IComponentRender {
		
		/**
		*	The component being rendered.
		*/
		function get component():IComponent;
		function set component( value:IComponent ):void;
		
		/**
		*	The rendering phase to be invoked.
		*/
		function get phase():String;
		function set phase( value:String ):void;
		
		/**
		*	Performs the rendering on the underlying component
		*	to be rendered.	
		*/
		function render():void;
	}
}