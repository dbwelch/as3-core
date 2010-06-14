package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;

	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.Locale;

	/**
	*	The implementation of the parser for configuration data.
	*  
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ConfigurationParser extends Parser
		implements IConfigurationParser {
		
		/**
		*	The node name for a collection of locales.	
		*/
		static public const LOCALES_NAME:String =
			"locales";
			
		/**
		*	The node name for an individual locale.	
		*/
		static public const LOCALE_NAME:String =
			"locale";
			
		/**
		*	The node name for the main string collection.
		*/
		static public const COPY_NAME:String =
			"copy";
			
		/**
		*	The node name for locale specific copy.
		*/
		static public const COPY_COLLECTION_NAME:String =
			"copy-collection";
			
		/**
		*	The node name for arbritrary settings.
		*/
		static public const SETTINGS_NAME:String =
			"settings";
			
		/**
		*	The node name for asset mappings.
		*/
		static public const ASSETS_NAME:String =
			"assets";
			
		/**
		*	The node name for the rsl collection.
		*/
		static public const RSLS_NAME:String =
			"rsls";
			
		/**
		*	The node name for a rsl.
		*/
		static public const RSL_NAME:String =
			"rsl";
			
		/**
		*	The node name for an array of alphas.
		*/
		static public const ALPHAS_NAME:String =
			"alphas";
			
		/**
		*	The node name for an array of ratios.
		*/
		static public const RATIOS_NAME:String =
			"ratios";
			
		/**
		*	The node name for an array of colors.
		*/
		static public const COLORS_NAME:String =
			"colors";

		/**
		*	Creates a <code>ConfigurationParser</code> instance.
		*	
		*	@param root The class to instantiate for the root node.
		*	@param node The class to use when no mapping can be found.
		*/
		public function ConfigurationParser(
			root:Class = null, node:Class = null )
		{
			if( !root )
			{
				root = Configuration;
			}
			
			super( root, node );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			
			classNodeNameMap.add(
				LocaleSet,
				LOCALES_NAME,
				LOCALES_NAME,
				false );
				
			classNodeNameMap.add(
				Locale,
				LOCALE_NAME,
				LOCALE_NAME,
				false );
				
			classNodeNameMap.add(
				LocaleAwareStringCollection,
				COPY_NAME,
				COPY_NAME,
				false );
				
			classNodeNameMap.add(
				StringCollection,
				COPY_COLLECTION_NAME,
				COPY_COLLECTION_NAME,
				false );
				
			classNodeNameMap.add(
				Settings,
				SETTINGS_NAME,
				SETTINGS_NAME,
				false );
				
			classNodeNameMap.add(
				StringCollection,
				ASSETS_NAME,
				ASSETS_NAME,
				false );
				
			classNodeNameMap.add(
				RuntimeSharedLibraryCollection,
				RSLS_NAME,
				RSLS_NAME,
				false );
				
			classNodeNameMap.add(
				RuntimeSharedLibrary,
				RSL_NAME,
				RSL_NAME,
				false );
				
			classNodeNameMap.add(
				Array,
				ALPHAS_NAME,
				ALPHAS_NAME,
				false );
				
			classNodeNameMap.add(
				Array,
				RATIOS_NAME,
				RATIOS_NAME,
				false );				
				
			classNodeNameMap.add(
				Array,
				COLORS_NAME,
				COLORS_NAME,
				false );				
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:IConfiguration = null ):IConfiguration
		{
			return _deserializer.deserialize( x, target ) as IConfiguration;
		}
	}
}