package org.flashx.ui.containers {
	
	import org.flashx.ui.core.UIComponent;
	import org.flashx.ui.layout.ILayout;
	import org.flashx.ui.layout.VerticalLayout;
	
	/**
	*	Container that lays out children vertically.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	dynamic public class VerticalBox extends Container {
		
		/**
		*	Creates a <code>VerticalBox</code> instance.
		*/
		public function VerticalBox()
		{
			super();
			this.layout = new VerticalLayout();
		}
		
		/**
		*	Ensures the layout is a vertical layout.	
		*/
		override public function set layout(
			layout:ILayout ):void
		{
			if( layout && !( layout is VerticalLayout ) )
			{
				throw new Error(
					"The layout for a vertical box must be vertical." );
			}
			
			super.layout = layout;
		}
	}
}