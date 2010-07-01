package com.ffsys.ui.core {
	
	import com.ffsys.ui.drag.IDraggable;
	import com.ffsys.ui.drag.IDragOperation;
	
	/**
	*	Describes the contract for interactive components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IInteractiveComponent
		extends IComponent,
		 		IDraggable {
		
		/**
		* 	Extends the enabled functionality to switch the hand cursor
		* 	and button mode on when interactive is <code>true</code>.
		*/
		function get interactive():Boolean;
		function set interactive( interactive:Boolean ):void;
		
		/**
		*	A drag operation associated with this component
		*	that indicates this component is draggable.
		*/
		function get drag():IDragOperation;
		function set drag( drag:IDragOperation ):void;		
	}
}