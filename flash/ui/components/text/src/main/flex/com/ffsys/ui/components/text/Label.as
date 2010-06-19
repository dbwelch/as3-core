package com.ffsys.ui.components.text
{
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.text.ConstrainedSingleLineTextField;

	/**
	*	Represents a textual label.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Label extends UIComponent
	{
		private var _textfield:ConstrainedSingleLineTextField;
		
		/**
		* 	Creates a <code>Label</code> instance.
		* 
		* 	@param text The text for the label.
		* 	@param properties Textfield properties to apply to the textfield.
		* 	@param textfield Textformat properties to apply to the default text
		* 	format.
		*/
		public function Label(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super();
			_textfield = textFieldFactory.constrained(
				text, properties, textformat );
			_textfield.enabled = false;
			this.enabled = false;
			addChild( _textfield );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set enabled( enabled:Boolean ):void
		{
			super.enabled = enabled;
			this.textfield.enabled = enabled;
		}
		
		/**
		* 	Gets the textfield this label is using to render text.
		*/
		public function get textfield():ConstrainedSingleLineTextField
		{
			return _textfield;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
			return textfield.getText();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set text( text:String ):void
		{
			textfield.setText( text );
		}
	}
}