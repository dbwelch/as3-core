package com.ffsys.css
{
	import flash.text.*;
	
	public class FontFamily extends Object
	{
		
		private static var _deviceFonts:Array = null;
		
		private var _fontNames:Array = null;
	
		/**
		* 	Creates a <code>FontFamily</code> instance.
		*/
		public function FontFamily( fontNames:Array = null )
		{
			super();
			this.fontNames = fontNames;
		}
		
		/**
		* 	Enables derived implementations to clear
		* 	the cache of device font names.
		*/
		protected function clearDeviceFontCache():void
		{
			_deviceFonts = null;
		}
		
		/**
		* 	A list of the device font names.
		* 
		* 	Device font names are cached in a class level
		* 	variable the first time this method is invoked.
		*/
		public function get deviceFonts():Array
		{
			if( _deviceFonts == null )
			{
				_deviceFonts = Font.enumerateFonts( true );
			}
			return _deviceFonts;
		}
		
		/**
		* 	A list of the embedded font names.
		*/
		public function get embeddedFonts():Array
		{
			return Font.enumerateFonts( false );
		}
		
		/**
		* 	Gets a dictionary that maps font names
		* 	to font implementations.
		* 
		* 	@return An object with keys that correspond
		* 	to font names and font values.
		*/
		public function getFontDictionary():Object
		{
			var output:Object = new Object();
			
			var device:Array = deviceFonts;
			var embedded:Array = embeddedFonts;
			var allFonts:Array = new Array().concat( device, embedded );
			var font:Font = null;
			for( var i:int = 0;i < allFonts.length;i++ )
			{
				font = allFonts[ i ];
				if( font != null )
				{
					output[ font.fontName ] = font;
				}
			}
			return output;
		}
		
		/**
		* 	Retrieves the name of the font to use.
		* 
		* 	@param embed Whether the font being applied
		* 	is declared as being embedded.
		* 	@param fte Whether the font declaration is being
		* 	applied to text created with the flash text engine.
		* 
		* 	@return The name of the first font in the font family
		* 	that matches the specifications.
		*/
		public function getFont( embed:Boolean = false, fte:Boolean = false ):String
		{
			if( isEmpty() )
			{
				return null;
			}
			
			trace("FontFamily::getFont()", embed, fte );

			var fonts:Object = getFontDictionary();
			var name:String = null;
			var font:Font = null;
			for( var i:int = 0;i < _fontNames.length;i++ )
			{
				name = _fontNames[ i ];
				
				trace("FontFamily::getFont()", name );
				
				if( fonts[ name ] is Font )
				{
					font = Font( fonts[ name ] );
					
					trace("FontFamily::getFont() GOT FONT: ", name, font );
					
					//looking for a device font
					if( !embed && font.fontType == FontType.DEVICE )
					{
						return name;
					}else if( embed
						&& ( font.fontType == ( fte ? FontType.EMBEDDED_CFF : FontType.EMBEDDED ) ) )
					{
						return name;
					}
				}
			}
			return null;
		}
		
		/**
		* 	Determines whether any font names have been
		* 	specified for this font family.
		*/
		public function isEmpty():Boolean
		{
			return _fontNames == null || _fontNames.length == 0;
		}
		
		/**
		* 	The list of font names for this font family.
		*/
		public function get fontNames():Array
		{
			return _fontNames;
		}
		
		public function set fontNames( value:Array ):void
		{
			_fontNames = value;
		}
	}
}