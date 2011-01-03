package com.ffsys.ui.text
{
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
			width:Number = 160,
			height:Number = 20 )
		{
			this.preferredWidth = width;
			this.preferredHeight = height;
			super( text );
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
				
				//
				textfield.width = this.innerWidth;
				textfield.height = this.innerHeight;
			}
			
			trace("TextInput::createTextField()", textfield, textfield.type, textfield.selectable, textfield.autoSize );
			
			return textfield;
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