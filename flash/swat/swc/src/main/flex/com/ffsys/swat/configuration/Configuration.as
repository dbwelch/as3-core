package com.ffsys.swat.configuration {
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.LocaleManager;
	import com.ffsys.swat.configuration.rsls.RuntimeSharedLibraryCollection;
	
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
			
			trace("Configuration::set locales(), ", locales.length );
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
		public function get copy():LocaleAwareStringCollection
		{
			return _locales.copy;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function set copy( copy:LocaleAwareStringCollection ):void
		{
			_locales.copy = copy;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get settings():Settings
		{
			return _locales.settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set settings( settings:Settings ):void
		{
			_locales.settings = settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get defaults():Defaults
		{
			return _locales.defaults;
		}

		/**
		*	@inheritDoc	
		*/
		public function set defaults( defaults:Defaults ):void
		{
			_locales.defaults = defaults;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get assets():StringCollection
		{
			return _locales.assets;
		}

		/**
		*	@inheritDoc
		*/		
		public function set assets( assets:StringCollection ):void
		{
			_locales.assets = assets;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():RuntimeSharedLibraryCollection
		{
			return _locales.rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set rsls( rsls:RuntimeSharedLibraryCollection ):void
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