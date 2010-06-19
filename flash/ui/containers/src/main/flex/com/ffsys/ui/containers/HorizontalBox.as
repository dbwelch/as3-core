package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.layout.HorizontalLayout;
	import com.ffsys.ui.layout.ILayout;
	
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
		
		
		/**
		*	Ensures the layout is a horizontal layout.	
		*/
		override public function set layout(
			layout:ILayout ):void
		{
			if( layout && !( layout is HorizontalLayout ) )
			{
				throw new Error(
					"The layout for a horizontal box must be horizontal." );
			}
			
			super.layout = layout;
		}
		
		/**
		*	The spacing for this horizontal box container.
		*/
		public function get spacing():Number
		{
			if( layout )
			{
				return HorizontalLayout( layout ).spacing;
			}
			
			return -1;
		}
		
		public function set spacing( spacing:Number ):void
		{
			if( layout )
			{
				HorizontalLayout( layout ).spacing = spacing;
			}
		}		
	}
}