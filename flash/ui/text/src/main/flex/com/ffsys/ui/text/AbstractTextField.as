package com.ffsys.ui.text {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.*;
	
	import com.ffsys.utils.properties.PropertiesMerge;
	
	/**
	*	Abstract super class for custom textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class AbstractTextField extends TextField
		implements ITextField {
		
		private var _enabled:Boolean = false;
		private var _html:Boolean = false;
		
		/**
		*	Creates an <code>AbstractTextField</code> instance.
		*/
		public function AbstractTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super();
			
			if( properties )
			{
				applyTextFieldProperties( properties );
			}
			
			if( textformat )
			{
				applyTextFormatProperties( textformat );
			}
			
			setText( text );
		}
		
		public function get html():Boolean
		{
			return _html;
		}
		
		public function set html( html:Boolean ):void
		{
			_html = html;
		}
		
		override public function appendText( text:String ):void
		{
			beforeSetText( text );
			super.appendText( text );
			afterSetText( text );
		}
		
		protected function beforeSetText( text:String ):void
		{
			//
		}
		
		protected function afterSetText( text:String ):void
		{
			//
		}
		
		/**
		* 	Sets the text of this textfield.
		*/
		public function setText( text:String ):void
		{
			beforeSetText( text );
			
			if( html )
			{
				this.htmlText = text;
			}else
			{
				this.text = text;
			}
			
			afterSetText( text );
		}
		
		/**
		* 	Gets the text associated with this textfield.
		*/
		public function getText():String
		{
			return html ? htmlText : text;
		}
		
		public function convertToSingleLine():void
		{
			wordWrap = false;
			multiline = false;
			autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function convertToMultiLine():void
		{
			wordWrap = true;
			multiline = true;
			autoSize = TextFieldAutoSize.LEFT;			
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled( enabled:Boolean ):void
		{
			mouseEnabled = enabled;
			_enabled = enabled;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyProperties(
			target:Object, properties:Object ):void
		{
			var merger:PropertiesMerge = new PropertiesMerge();
			merger.merge( target, properties );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFieldProperties(
			properties:Object ):void
		{
			applyProperties( this, properties );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFormatProperties(
			properties:Object ):void
		{
			var tf:TextFormat = this.defaultTextFormat;
			
			if( tf != null )
			{
				applyProperties( tf, properties );
			}
			
			this.defaultTextFormat = tf;
			setText( this.text );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBitmap( matrix:Matrix = null ):Bitmap
		{
			if( matrix == null )
			{
				matrix = new Matrix();
			}
			
			var bitmapData:BitmapData = new BitmapData(
				this.width, this.height, true, 0x00000000 );
			bitmapData.draw( this, matrix );
			return new Bitmap( bitmapData );
		}
	}
}