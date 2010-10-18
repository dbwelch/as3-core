package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;

	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.Locale;
	
	import com.ffsys.swat.configuration.filters.*;
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.swat.configuration.rsls.*;

	/**
	*	A parser implementation for the application configuration.
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
		*	The node name for a configuration.
		*/
		
		/*
		static public const CONFIGURATION_NAME:String =
			"configuration";
		*/
		
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
		*	The node name for the fallback locale.
		*/
		static public const DEFAULT_LOCALE_NAME:String =
			"default-locale";
			
		/**
		*	The property name for the fallback locale.
		*/
		static public const DEFAULT_LOCALE_PROPERTY_NAME:String =
			"defaultLocale";
			
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
		*	The node name for application messages.
		*/
		static public const MESSAGES_NAME:String =
			"messages";
			
		/**
		*	The node name for application error messages.
		*/
		static public const ERRORS_NAME:String =
			"errors";
			
		/**
		*	The node name for application fonts.
		*/
		static public const FONTS_NAME:String =
			"fonts";
			
		/**
		*	The node name for application images.
		*/
		static public const IMAGES_NAME:String =
			"images";
			
		/**
		*	The node name for application XML documents.
		*/
		static public const XML_NAME:String =
			"xml";
			
		/**
		*	The node name for application CSS documents.
		*/
		static public const CSS_NAME:String =
			"css";			
			
		/**
		*	The node name for application sounds.
		*/
		static public const SOUNDS_NAME:String =
			"sounds";

		/**
		*	The node name for a collection of resources.
		*/
		static public const RESOURCES_NAME:String =
			"resources";
			
		/**
		*	The node name for a resource definition.
		*/
		static public const RESOURCE_NAME:String =
			"resource";			

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
			
			/*
			classNodeNameMap.add(
				Configuration,
				CONFIGURATION_NAME,
				CONFIGURATION_NAME,
				false );
			*/
			
			classNodeNameMap.rootInstance = new Configuration();
			
			classNodeNameMap.add(
				LocaleManager,
				LOCALES_NAME,
				LOCALES_NAME,
				false );
				
			classNodeNameMap.add(
				ConfigurationLocale,
				LOCALE_NAME,
				LOCALE_NAME,
				false );
				
			classNodeNameMap.add(
				ConfigurationLocale,
				DEFAULT_LOCALE_NAME,
				DEFAULT_LOCALE_PROPERTY_NAME,
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
				RslCollection,
				RSLS_NAME,
				RSLS_NAME,
				false );
				
			classNodeNameMap.add(
				PropertiesCollection,
				MESSAGES_NAME,
				MESSAGES_NAME,
				false );

			classNodeNameMap.add(
				PropertiesCollection,
				ERRORS_NAME,
				ERRORS_NAME,
				false );

			classNodeNameMap.add(
				FontCollection,
				FONTS_NAME,
				FONTS_NAME,
				false );
				
			classNodeNameMap.add(
				ImageCollection,
				IMAGES_NAME,
				IMAGES_NAME,
				false );
				
			classNodeNameMap.add(
				XmlCollection,
				XML_NAME,
				XML_NAME,
				false );	
				
			classNodeNameMap.add(
				CssCollection,
				CSS_NAME,
				CSS_NAME,
				false );				
				
			classNodeNameMap.add(
				SoundCollection,
				SOUNDS_NAME,
				SOUNDS_NAME,
				false );						
				
			classNodeNameMap.add(
				RuntimeSharedLibrary,
				RSL_NAME,
				RSL_NAME,
				false );
				
			classNodeNameMap.add(
				LocaleResources,
				RESOURCES_NAME,
				RESOURCES_NAME,
				false );				
				
			classNodeNameMap.add(
				RuntimeResource,
				RESOURCE_NAME,
				RESOURCE_NAME,
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