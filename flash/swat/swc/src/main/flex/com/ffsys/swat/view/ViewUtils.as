package com.ffsys.swat.view  {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IPaths;
	import com.ffsys.swat.configuration.ISettings;
	
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	*	Encapsulates access to various commonly used configuration
	*	properties and other utility functionality such as a textfield
	*	factory to simplify the process of creating textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ViewUtils extends Object
		implements IViewUtils {
		
		/*	
		static private var _textFieldFactory:ITextFieldFactory
			= new TextFieldFactory();
		*/
		
		private var _configuration:IConfiguration;
		
		/**
		*	Creates an <code>ViewUtils</code> instance.
		*/
		public function ViewUtils()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		public function get textFieldFactory():ITextFieldFactory
		{
			return _textFieldFactory;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			verifyConfiguration();
			return this.configuration.flashvars;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get assetManager():AssetManager
		{
			verifyConfiguration();
			return this.configuration.assetManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get settings():ISettings
		{
			verifyConfiguration();
			return this.configuration.settings;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get assets():IStringCollection
		{
			verifyConfiguration();
			return this.configuration.assets;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			verifyConfiguration();
			return this.configuration.getFilter( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getMessage.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getError.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			verifyConfiguration();
			return this.configuration.getImage( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			verifyConfiguration();
			return this.configuration.getXmlDocument( id );			
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getStyleSheet( id:String ):ICssStyleSheet
		{
			verifyConfiguration();
			return this.configuration.getStyleSheet( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			verifyConfiguration();
			return this.configuration.styleManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			verifyConfiguration();
			return this.configuration.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			verifyConfiguration();
			this.configuration.setStyle( styleName, style );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			verifyConfiguration();
			return this.configuration.getSound( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLocalePath( path:String, locale:IConfigurationLocale = null ):String
		{
			if( locale == null )
			{
				locale = configuration.locales.current;
			}
			
			var paths:IPaths = configuration.paths;
			var out:String = paths.join(
				[ paths.getLocalePath( locale ) ], path );
			return out;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function registerFont( classPath:String ):Font
		{
			var instance:Object = null;
			
			var clz:Class = null;

			try
			{
				clz = Class( getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not find a class for font class '"
						+ classPath + "'." );
			}
			
			try
			{
				instance = new clz();
			}catch( e:Error )
			{
				throw new Error(
					"Could not instantiate font instance with class path '"
						+ classPath + "'." );
			}
			
			if( !( instance is Font ) )
			{
				throw new Error(
					"Instantiated instance from class path '"
						+ classPath + "' is not a font." );
			}

			Font.registerFont( clz );
			return Font( instance );
		}
		
		/**
		*	@private	
		*/
		private function verifyConfiguration():void
		{
			if( this.configuration == null )
			{
				throw new Error(
					"Cannot access view utilities with a null configuration." );
			}
		}
	}
}