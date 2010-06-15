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
		
		/**
		*	Creates an <code>AbstractTextField</code> instance.
		*/
		public function AbstractTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super();
			this.text = text;
			
			if( properties )
			{
				applyTextFieldProperties( properties );
			}
			
			if( textformat )
			{
				applyTextFormatProperties( textformat );
			}
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