package com.ffsys.ui.text
{
	import flash.geom.Rectangle;
	import flash.text.*;
	
	import com.ffsys.ui.text.core.*;

	/**
	*	A component that accepts text input.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextInput extends TextComponent
	{	
		/**
		* 	Creates a <code>TextInput</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param width The preferred width for this component.
		* 	@param height The preferred height for this component.
		*/
		public function TextInput(
			text:String = "",
			width:Number = 220,
			height:Number = NaN )
		{
			super( text );
			//trace("TextInput::()", width, height );
			this.preferredWidth = width;
			this.preferredHeight = height;
			//trace("TextInput::init()", preferredWidth, preferredHeight );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			if( !isNaN( preferredWidth ) )
			{
				return preferredWidth;
			}
			return super.layoutWidth;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			if( !isNaN( preferredHeight ) )
			{
				return preferredHeight
			}
			return super.layoutHeight;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function createTextField( text:String ):ITypedTextField
		{
			super.createTextField( text );
			
			if( textfield != null )
			{
				textfield.type = TextFieldType.INPUT;
				textfield.selectable = true;
				this.interactive = true;
				this.enabled = true;
				this.mouseChildren = true;
				textfield.autoSize = TextFieldAutoSize.NONE;
				textfield.wordWrap = false;
				useHandCursor = false;
				textfield.multiline = ( this is TextArea );
				textfield.wordWrap = ( this is TextArea );
			}
			
			//trace("TextInput::createTextField()", textfield, textfield.type, textfield.selectable, textfield.autoSize );
			
			return textfield;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			super.finalized();
			if( textfield != null )
			{
				textfield.autoSize = TextFieldAutoSize.NONE;
				var rect:Rectangle = getBackgroundRect();
				
				//TODO: add offset back to the inner dimensions
				textfield.width = innerWidth;
				if( this is TextArea )
				{
					textfield.height = innerHeight;
				}
				//trace("TextInput::finalized()", preferredWidth, preferredHeight,textfield.width, textfield.height, textfield.wordWrap, textfield.embedFonts );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getTextFieldClass():Class
		{
			return FixedSingleLineTextField;
		}
	}
}