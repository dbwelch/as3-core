package org.flashx.ui.buttons {
	
	import org.flashx.ui.graphics.*;
	
	/**
	*	Represents a graphical button that can have
	*	state information but never has a text label.
	*	
	*	Examples of this type of button are the scroll track
	*	and scroll drag components used by the scroll bar.
	* 
	* 	The <code>background</code> is used as the graphic
	* 	for the button.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.07.2010
	*/
	public class GraphicButton extends ButtonComponent {
		
		/**
		*	Creates a <code>GraphicButton</code> instance.	
		*/
		public function GraphicButton()
		{
			super();
		}
		
		/**
		* 	Ensures the background graphic is kept in sync
		* 	with the dimensions of this component.
		*/
		override public function set background( value:IComponentGraphic ):void
		{
			super.background = value;
			
			//ensure the background graphic dimensions are kept in
			//sync with our dimensions as style states change
			applyBackground();
		}
	}
}