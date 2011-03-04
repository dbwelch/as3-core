package com.ffsys.ui.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.layout.IFixedLayout;
	
	/**
	*	Describes the contract for components that serve as a mask.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IMaskComponent
		extends IComponent,
		 		IFixedLayout {
		/**
		* 	A target display object to be masked by
		* 	this component.
		*/
		function get target():DisplayObject;
		function set target( value:DisplayObject ):void;
	}
}