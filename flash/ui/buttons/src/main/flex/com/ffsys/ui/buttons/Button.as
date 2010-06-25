package com.ffsys.ui.buttons {
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.skins.ComponentSkin;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
	import com.ffsys.ui.states.State;
	
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
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			
			/*
			if( label )
			{
				width = label.layoutWidth + paddings.left + paddings.right;
			}
			*/
			
			return width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredHeight():Number
		{
			var height:Number = super.preferredHeight;
			
			/*
			if( label )
			{
				height = label.layoutHeight + paddings.left + paddings.right;
			}
			*/
			
			return height;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function configureDefaultSkin():void
		{
			//main state for this component
			var main:IViewState = new ViewState();
			
			main.graphics.push(
				new RoundedRectangleGraphic(
					width,
					height ) );
					
			main.fills.push(
				new SolidFill( 0xff0000, 0.5 ) );
			
			this.skin.addState( main );
			
			var over:IViewState = new ViewState( 
			 	State.OVER );
					
			over.fills.push(
				new SolidFill( 0x00ff00, 0.5 ) );
			
			this.skin.addState( over );
	
			trace("Button::configureDefaultSkin(), ", "CONFIGURING DEFAULT SKIN", this.skin.length );			
		}
	}
}