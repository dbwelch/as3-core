package com.ffsys.ui.components.containers {
	
	import com.ffsys.ui.components.core.UIComponent;
	import com.ffsys.ui.components.layout.VerticalLayout;
	
	/**
	*	Container that lays out children vertically.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class VerticalBox extends UIComponent {
		
		/**
		*	Creates a <code>VerticalBox</code> instance.
		*/
		public function VerticalBox()
		{
			super();
			this.layout = new VerticalLayout();
		}
	}
}