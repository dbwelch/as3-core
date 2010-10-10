package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;	
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	import com.ffsys.utils.css.CssStyleCollection;
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.LocaleManager;
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
	/**
	*	Represents the application configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class Configuration extends Object 
		implements IConfiguration {
			
		private var _flashvars:IFlashVariables;
		private var _locales:ILocaleManager;
		private var _assetManager:AssetManager;
		
		/**
		*	Create a <code>Configuration</code> instance.
		*/
		public function Configuration()
		{
			super();
			_assetManager = new AssetManager( this );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}

		public function set flashvars( flashvars:IFlashVariables ):void
		{
			_flashvars = flashvars;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get locales():ILocaleManager
		{
			return _locales;
		}

		public function set locales( locales:ILocaleManager ):void
		{
			_locales = locales;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return _locales.getMessage.apply( _locales, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return _locales.getError.apply( _locales, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getStyleSheet( id:String ):CssStyleCollection
		{
			return _locales.getStyleSheet( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			return _locales.getImage( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			return _locales.getSound( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			return _locales.getFilter( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get assetManager():AssetManager
		{
			return _assetManager;
		}

		public function set assetManager( assetManager:AssetManager ):void
		{
			_assetManager = assetManager;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get settings():ISettings
		{
			return _locales.settings;
		}

		public function set settings( settings:ISettings ):void
		{
			_locales.settings = settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get defaults():IDefaults
		{
			return _locales.defaults;
		}
		
		public function set defaults( defaults:IDefaults ):void
		{
			_locales.defaults = defaults;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get assets():IStringCollection
		{
			return _locales.assets;
		}
	
		public function set assets( assets:IStringCollection ):void
		{
			_locales.assets = assets;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get filters():IFilterCollection
		{
			return _locales.filters;
		}

		/**
		*	@inheritDoc
		*/
		public function set filters( filters:IFilterCollection ):void
		{
			_locales.filters = filters;
		}
	}
}