package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.layout.HorizontalLayout;
	
	/**
	*	Container that lays out children horizontally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class HorizontalBox extends UIComponent {
		
		/**
		*	Creates a <code>HorizontalBox</code> instance.
		*/
		public function HorizontalBox()
		{
			super();
			this.layout = new HorizontalLayout();
		}
	}
}