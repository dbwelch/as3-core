package com.ffsys.swat.configuration {
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
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
		
		/**
		* 	@inheritDoc
		*/
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
		
		/**
		*	@inheritDoc
		*/
		public function set locales( locales:ILocaleManager ):void
		{
			_locales = locales;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get assetManager():AssetManager
		{
			return _assetManager;
		}
		
		/**
		*	@inheritDoc
		*/
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
		
		/**
		*	@inheritDoc	
		*/
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

		/**
		*	@inheritDoc	
		*/
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

		/**
		*	@inheritDoc
		*/		
		public function set assets( assets:IStringCollection ):void
		{
			_locales.assets = assets;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():IRuntimeResourceCollection
		{
			return _locales.rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set rsls( rsls:IRuntimeResourceCollection ):void
		{
			_locales.rsls = rsls;
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