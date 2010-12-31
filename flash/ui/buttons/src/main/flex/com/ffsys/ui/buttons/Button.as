package com.ffsys.ui.buttons {
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.core.State;
	
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
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function Button(
			text:String = "",
			width:Number = NaN,
			height:Number = NaN )
		{	
			//paddings.padding = 4
			super( text, width, height );
		}		
		
		/**
		* 	Ensures that the background is drawn to our preferred dimensions.
		*/
		override public function set text( value:String ):void
		{
			super.text = value;
			if( this.background != null )
			{
				this.background.preferredWidth = this.preferredWidth;
				this.background.preferredHeight = this.preferredHeight;
				this.background.draw();
			}
		}
		
		/**
		* 	Ensures that the background is drawn to our preferred dimensions.
		*/
		override public function set background( value:IComponentGraphic ):void
		{
			super.background = value;
			if( this.background != null
			 	&& this.label != null )
			{
				this.background.preferredWidth = this.preferredWidth;
				this.background.preferredHeight = this.preferredHeight;
				this.background.draw();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function created():void
		{
			this.paddings.padding = 4;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			if( label )
			{
				width = label.layoutWidth + paddings.left + paddings.right;
			}
			
			return width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredHeight():Number
		{
			var height:Number = super.preferredHeight;
			if( label )
			{
				height = label.layoutHeight + paddings.left + paddings.right;
			}
			
			return height;
		}
	}
}