package org.flashx.ui.text
{
	import flash.text.*;
	import org.flashx.ui.core.UIComponent;

	dynamic public class FteTextArea extends UIComponent
		implements ITextComponent
	{
		private var _text:String;
		private var _contentText:String;
		
		/**
		* 	Creates an <code>FteTextArea</code> instance.
		*/
		public function FteTextArea()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			return this.width;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			return this.height;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get html():Boolean
		{
			return true;
		}
		
		public function set html( html:Boolean ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get fte():Boolean
		{
			return true;
		}
		
		public function set fte( value:Boolean ):void
		{
			//TODO
		}
		
		public function get textfield():TextField
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get contentText():String
		{
			return _contentText;
		}
		
		public function set contentText( value:String ):void
		{
			_contentText = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
			return _text;
		}
		
		public function set text( value:String ):void
		{
			_text = value;
		}
	}
}