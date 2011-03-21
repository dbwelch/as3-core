package org.flashx.ui.buttons
{
	import flash.display.DisplayObject;
	
	/**
	*	Represents a button that contains an icon
	* 	but does not include a background graphic
	* 	in the default styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class IconTextButton extends IconButton
	{
		/**
		* 	Creates an <code>IconTextButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function IconTextButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( icon, text, width, height );
		}
	}
}