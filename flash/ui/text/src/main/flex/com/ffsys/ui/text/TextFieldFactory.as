package com.ffsys.ui.text {
	
	import flash.text.*;
	
	/**
	*	Factory class for creating and working with textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class TextFieldFactory extends Object
		implements ITextFieldFactory {
		
		/**
		*	Creates a <code>TextFieldFactory<code> instance.
		*/
		public function TextFieldFactory()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function single(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):SingleLineTextField
		{
			var txt:SingleLineTextField = new SingleLineTextField(
				text, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
		
		/**
		*	@inheritDoc
		*/
		public function constrained(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):ConstrainedSingleLineTextField
		{
			var txt:ConstrainedSingleLineTextField = new ConstrainedSingleLineTextField(
				text, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
		
		/**
		*	@inheritDoc
		*/
		public function multi(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):MultiLineTextField
		{
			var txt:MultiLineTextField = new MultiLineTextField(
				text, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
	}
}