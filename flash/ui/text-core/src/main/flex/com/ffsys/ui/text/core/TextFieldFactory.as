package com.ffsys.ui.text.core {
	
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
			
		private var _defaultTextFieldProperties:Object;
		private var _defaultTextFormatProperties:Object;
		
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
		public function get defaultTextFieldProperties():Object
		{
			return _defaultTextFieldProperties;
		}
		
		public function set defaultTextFieldProperties(
			properties:Object ):void
		{
			_defaultTextFieldProperties = properties;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get defaultTextFormatProperties():Object
		{
			return _defaultTextFormatProperties;
		}
		
		public function set defaultTextFormatProperties(
			properties:Object ):void
		{
			_defaultTextFormatProperties = properties;
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
			var txt:SingleLineTextField =
				new SingleLineTextField( text );
			
			applyProperties( txt, properties, textformat );
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
			var txt:ConstrainedSingleLineTextField =
				new ConstrainedSingleLineTextField( text );
			
			applyProperties( txt, properties, textformat );
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
			var txt:MultiLineTextField =
				new MultiLineTextField( text );
			
			applyProperties( txt, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
		
		/**
		*	@inheritDoc
		*/
		public function fixed(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):FixedSingleLineTextField
		{
			var txt:FixedSingleLineTextField =
				new FixedSingleLineTextField( text );
			
			applyProperties( txt, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getTextFieldByClass(
			clazz:Class,
			text:String = "",
			properties:Object = null,
			textformat:Object = null ):ITypedTextField
		{
			var textfield:ITypedTextField = getTextFieldInstance( clazz, text );
			applyProperties( textfield, properties, textformat );
			return textfield;
		}
		
		private function getTextFieldInstance( clazz:Class, text:String = "" ):ITypedTextField
		{
			var instance:Object = null;
			
			if( clazz == null )
			{
				throw new Error( "Cannot instantiate a factory textfield with a null class." );
			}
			
			try
			{
				instance = new clazz( text );
			}catch( e:Error )
			{
				throw new Error( "Could not instantiate a factory textfield from class '"
				 	+ clazz + "'." );
			}
			
			if( !( instance is ITypedTextField ) )
			{
				throw new Error( "Textfield instance does not adhere to the textfield contract." );
			}
			
			return ITypedTextField( instance );
		}
		
		/**
		*	@private	
		*/
		private function applyProperties(
			txt:ITypedTextField,
			properties:Object,
			textformat:Object ):void
		{
			
			if( defaultTextFieldProperties )
			{
				txt.applyTextFieldProperties( defaultTextFieldProperties );
			}
			
			if( properties )
			{
				txt.applyTextFieldProperties( properties );
			}
			
			if( defaultTextFormatProperties )
			{
				txt.applyTextFormatProperties( defaultTextFormatProperties );
			}
			
			if( textformat )
			{
				txt.applyTextFormatProperties( textformat );
			}
		}
	}
}