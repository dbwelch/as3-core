package com.ffsys.ui.scrollbars
{
	import flash.display.DisplayObject;
	import com.ffsys.ui.buttons.UpButton;
	
	/**
	*	Represents a button for scrolling up.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public class ScrollUpButton extends UpButton
	{
		//TODO: refactor this embed to a class level definition to avoid the flex framework compiler link problem		
		[Embed(source="../../../../../resources/scroll-up.png")]
		static private var _defaultIconClass:Class;
		
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
			width:Number = NaN,
			height:Number = NaN )		
		{
			if( icon == null )
			{
				icon = DisplayObject( getRuntimeInstance( _defaultIconClass ) );
			}
			
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