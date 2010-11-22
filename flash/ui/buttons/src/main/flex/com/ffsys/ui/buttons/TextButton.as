package com.ffsys.ui.buttons
{
	import flash.text.TextField;
	import com.ffsys.ui.text.Label;
	
	import com.ffsys.ui.css.ICssTextFieldProxy;

	/**
	*	Represents a button that consists of a single
	* 	text field.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextButton extends ButtonComponent
		implements ICssTextFieldProxy
	{
		private var _text:String;
		private var _label:Label;
		
		/**
		* 	Creates a <code>TextButton</code> instance.
		*	
		*	@param text The text for the button.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function TextButton(
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( width, height );
			this.text = text;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getProxyTextFields():Vector.<TextField>
		{
			var output:Vector.<TextField> = new Vector.<TextField>();
			if( _label && _label.textfield )
			{
				output.push( TextField( _label.textfield ) );
			}
			return output;
		}
		
		/**
		*	The text for the button.	
		*/
		public function get text():String
		{
			return _text;
		}
		
		public function set text( text:String ):void
		{
			if( ( !text || text == "" ) && _label && contains( _label ) )
			{
				removeChild( _label );
			}
			
			_text = text;
			
			if( this.text && this.text != "" )
			{
				_label = new Label( text );
				_label.x = paddings.left;
				_label.y = paddings.top;
				_label.applyStyles();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			if( _label 
				&& !contains( _label ) )
			{
				addChild( _label );
			}
			
			super.createChildren();			
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
		
		/**
		* 	The label being used to render the text for this button.
		*/
		public function get label():Label
		{
			return _label;
		}
	}
}