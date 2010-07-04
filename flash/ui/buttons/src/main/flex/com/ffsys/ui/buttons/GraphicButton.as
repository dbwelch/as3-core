package com.ffsys.ui.buttons {
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
	import com.ffsys.ui.states.State;	
	
	/**
	*	Represents a graphical button that can have
	*	state information but never has a text label.
	*	
	*	Examples of this type of button are the scroll track
	*	and scroll drag components used by the scroll bar.
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
		*	@inheritDoc	
		*/
		override protected function configureDefaultSkin():void
		{
			//main state for this component
			var main:IViewState = new ViewState();
			
			main.graphics.push(
				new RectangleGraphic(
					width,
					height ) );
					
			main.fills.push(
				new SolidFill( 0x212121 ) );
			
			this.skin.addState( main );
			
			var over:IViewState = new ViewState( 
			 	State.OVER );
					
			over.fills.push(
				new SolidFill( 0x62592e ) );
			
			this.skin.addState( over );
		}		
	}
}