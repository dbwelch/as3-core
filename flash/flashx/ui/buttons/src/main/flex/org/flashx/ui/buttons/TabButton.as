package org.flashx.ui.buttons
{
	import flash.display.DisplayObject;
	
	/**
	*	Represents a button style for buttons
	* 	contained in tab containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public class TabButton extends IconButton
	{
		/**
		* 	Creates a <code>TabButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function TabButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( icon, text, width, height );
			this.selectable = true;
		}
	}
}