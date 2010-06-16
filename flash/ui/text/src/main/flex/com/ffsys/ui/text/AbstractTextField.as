package com.ffsys.ui.text {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.*;
	
	/**
	*	Abstract super class for custom textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class AbstractTextField extends TextField {
		
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
			trace("AbstractTextField::setText()", text );
			
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
			if( target != null )
			{
				var z:String = null;
				for( z in properties )
				{
					if( target.hasOwnProperty( z ) )
					{
						target[ z ] = properties[ z ];
					}
				}
			}
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
			this.text = this.text;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBitmap():Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(
				this.width, this.height, true, 0x00000000 );
			bitmapData.draw( this );
			return new Bitmap( bitmapData );
		}
	}
}