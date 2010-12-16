package com.ffsys.ui.buttons {
	
	import flash.display.DisplayObject;
	
	/**
	*	Represents a forward button.
	*	
	*	This implementation provides a default icon
	*	if none is specified.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class ForwardButton extends IconButton {
		
		//TODO: refactor this embed to a class level definition to avoid the flex framework compiler link problem
		[Embed(source="../../../../../resources/next-icon.png")]
		static private var _defaultIconClass:Class;
		
		/**
		*	Creates a <code>ForwardButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function ForwardButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super(
				icon != null ? icon : DisplayObject( getRuntimeInstance( _defaultIconClass ) ),
				text, width, height );
		}
	}
}