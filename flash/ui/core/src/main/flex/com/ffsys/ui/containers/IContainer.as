package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.IInteractiveComponent;
	import com.ffsys.ui.layout.ILayout;
	
	/**
	*	Describes the contract for container components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface IContainer
		extends IInteractiveComponent {
		
		/**
		*	The layout implementation for the container.
		*/
		function get layout():ILayout;
		function set layout( layout:ILayout ):void;
		
		
		/**
		*	The spacing for this container layout.
		* 
		* 	If no layout has been assigned to this container
		* 	then this setting will have no effect.
		*/
		function get spacing():Number;
		function set spacing( spacing:Number ):void;
		
		/**
		* 	Updates this container layout.
		* 
		* 	If no layout is assigned to this container
		* 	this implementation should ensure child display object positions
		* 	respect the paddings and margins of this container.s
		*/
		function update():void;
	}
}