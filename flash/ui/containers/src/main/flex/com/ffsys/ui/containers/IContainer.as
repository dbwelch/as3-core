package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.IComponent;
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
		extends IComponent {
		
		/**
		*	The layout implementation for the container.
		*/
		function get layout():ILayout;
		function set layout( layout:ILayout ):void;
	}
}