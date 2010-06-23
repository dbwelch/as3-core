package com.ffsys.ui.buttons {
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.skins.ComponentSkin;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
	
	/**
	*	Represents a standard button.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public class Button extends TextButton {
		
		/**
		*	Creates a <code>Button</code> instance.
		*	
		*	@param text The text for the button label.
		*/
		public function Button(
			text:String = "" )
		{
			super( text );

			//default skin for this component
			this.skin = new ComponentSkin();
			var main:IViewState = new ViewState();
			
			main.graphics.push(
				new RoundedRectangleGraphic(
					width,
					height ) );
					
			main.fills.push(
				new SolidFill( 0xff0000, 0.5 ) );
			
			this.skin.addState( main );
		}
	}
}