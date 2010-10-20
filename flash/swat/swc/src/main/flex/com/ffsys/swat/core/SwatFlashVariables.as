package com.ffsys.swat.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	
	import com.ffsys.core.AbstractFlashVars;
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	
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
		
		private var _lang:String = "en-GB";
		private var _configuration:String = "assets/common/xml/configuration.xml";
		private var _classes:String = null;
		private var _classPathConfiguration:IClassPathConfiguration;
		
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
		*	Gets the class path to the class path configuration class.
		*	
		*	@return The class path configuration class path.
		*/
		public function get classes():String
		{
			return _classes;
		}
		
		/**
		*	Sets the class path to the class path configuration class.
		*	
		*	@param classes The class path configuration class path.
		*/		
		public function set classes( classes:String ):void
		{
			_classes = classes;
		}
		
		/**
		*	Gets the class path configuration instance.
		*	
		*	@return The class path configuration instance.
		*/
		public function get classPathConfiguration():IClassPathConfiguration
		{
			return _classPathConfiguration;
		}
		
		/**
		*	Sets the class path configuration instance.
		*	
		*	@param classPathConfiguration The class path configuration instance.
		*/
		public function set classPathConfiguration(
			classPathConfiguration:IClassPathConfiguration ):void
		{
			_classPathConfiguration = classPathConfiguration;
		}
		
		/**
		*	Converts the value to a primitive value.
		*	
		*	@inheritDoc
		*/
		override protected function convert( name:String, value:String ):*
		{
			var parser:PrimitiveParser = new PrimitiveParser();
			return parser.parse( value );
		}
	}
}