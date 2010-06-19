package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.layout.ILayout;
	import com.ffsys.ui.layout.VerticalLayout;
	
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
		
		/**
		*	The spacing for this vertical box container.
		*/
		public function get spacing():Number
		{
			if( layout )
			{
				return VerticalLayout( layout ).spacing;
			}
			
			return -1;
		}
		
		public function set spacing( spacing:Number ):void
		{
			if( layout )
			{
				VerticalLayout( layout ).spacing = spacing;
			}
		}
	}
}