package com.ffsys.ui.core {
	
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
		*	The graphic that serves as the mask when this
		*	component is applied as a mask.
		*/
		function get graphic():IComponentGraphic;
		function set graphic( value:IComponentGraphic ):void;
	}
}