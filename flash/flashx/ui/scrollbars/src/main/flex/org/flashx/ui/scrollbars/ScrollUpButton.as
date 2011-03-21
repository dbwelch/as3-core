package org.flashx.ui.scrollbars
{
	import flash.display.DisplayObject;
	
	import org.flashx.ui.buttons.IconButton;
	
	/**
	*	Represents a button for scrolling up.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public class ScrollUpButton extends IconButton
	{
		
		/**
		* 	Creates a <code>ScrollUpButton</code> instance.
		* 
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function ScrollUpButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = 12,
			height:Number = 12 )
		{
			super( icon, text, width, height );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set interactive(
			value:Boolean ):void
		{
			super.interactive = value;
			useHandCursor = false;
			buttonMode = false;
		}
	}
}