package org.flashx.ui.buttons
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	*	Represents a button that toggles between
	* 	a selected and normal state when clicked.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public class ToggleButton extends IconButton
	{
		/**
		* 	Creates a <code>ToggleButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function ToggleButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( icon, text, width, height );
			this.selectable = true;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseClick(
			event:MouseEvent ):void
		{
			super.onMouseClick( event );
			if( selectable )
			{
				this.selected = !this.selected;
			}
		}
	}
}