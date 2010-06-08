package com.ffsys.swat.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.core.AbstractFlashVars;
	
	/**
	*	Encapsulates the data passed in via flash variables
	*	from the container embedding this movie.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatFlashVariables extends AbstractFlashVars {
		
		private var _lang:String = "en_GB";
		private var _configuration:String = "assets/xml/configuration.xml";
		private var _main:String = null;
		private var _preloader:String = null;
		
		/**
		*	Creates a <code>SwatFlashVariables</code> instance.
		*	
		*	@param root The root of the display list hierarchy.
		*/
		public function SwatFlashVariables( root:DisplayObject )
		{
			super( root );
		}
		
		/**
		*	Gets the ISO 639-1 and ISO_3166-1_alpha-2 language code
		* 	that specifies the locale to use.
		*	
		*	@return The language code.
		*/
		public function get lang():String
		{
			return _lang;
		}
		
		/**
		*	Sets the ISO 639-1 and ISO_3166-1_alpha-2 language code
		* 	that specifies the locale to use.
		*	
		*	@param lang The language code.
		*/		
		public function set lang( lang:String ):void
		{
			_lang = lang;
		}
		
		/**
		*	Gets the path to the configuration XML document.
		*	
		*	@return The configuration path.
		*/
		public function get configuration():String
		{
			return _configuration;
		}
		
		/**
		*	Sets the path to the configuration XML document.
		*	
		*	@param configuration The configuration path.
		*/		
		public function set configuration( configuration:String ):void
		{
			_configuration = configuration;
		}
		
		/**
		*	Gets the class path to the main application class.
		*	
		*	@return The main application class path.
		*/
		public function get main():String
		{
			return _main;
		}
		
		/**
		*	Sets the class path to the main application class.
		*	
		*	@param main The main application class path.
		*/		
		public function set main( main:String ):void
		{
			_main = main;
		}
		
		/**
		*	Gets the class path to the application preloader class.
		*	
		*	@return The application preloader class path.
		*/
		public function get preloader():String
		{
			return _preloader;
		}
		
		/**
		*	Sets the class path to the application preloader class.
		*	
		*	@param preloader The application preloader class path.
		*/		
		public function set preloader( preloader:String ):void
		{
			_preloader = preloader;
		}
	}
}