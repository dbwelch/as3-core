package com.ffsys.ui.buttons {
	
	import flash.display.DisplayObject;
	
	/*
	import com.ffsys.ui.common.Orientation;
	import com.ffsys.ui.graphics.ArowGraphic;
	*/
	
	/**
	*	Represents an up button.
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
	public class UpButton extends IconButton {
		
		//TODO: refactor this embed to a class level definition to avoid the flex framework compiler link problem
		[Embed(source="../../../../../resources/up-icon.png")]
		static private var _defaultIconClass:Class;
		
		/**
		*	Creates a <code>UpButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function UpButton(
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