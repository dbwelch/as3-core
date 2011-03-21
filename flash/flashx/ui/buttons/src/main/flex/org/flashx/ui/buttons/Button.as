package org.flashx.ui.buttons {
	
	import org.flashx.ui.graphics.*;
	import org.flashx.ui.text.TextComponent;	
	import org.flashx.ui.core.State;
	
	/**
	*	Represents a standard button.
	* 
	* 	This component includes a background graphic
	* 	in the default styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	dynamic public class Button extends TextButton {
		
		/**
		*	Creates a <code>Button</code> instance.
		*	
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function Button(
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( text, width, height );
		}
		
		/**
		* 	Ensures that the background is drawn to our preferred dimensions.
		*/
		override public function set text( value:String ):void
		{
			super.text = value;
			if( this.background != null )
			{
				applyBackground();
			}
		}
		
		/**
		* 	Ensures that the background is drawn to our preferred dimensions.
		*/
		override public function set background( value:IComponentGraphic ):void
		{
			super.background = value;
			if( this.background != null
			 	&& this.label != null )
			{
				trace("Button::set background()", getBackgroundRect() );
				applyBackground();
			}
		}		
	}
}