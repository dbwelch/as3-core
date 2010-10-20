package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.Locale;
	
	import com.ffsys.swat.configuration.rsls.IResourceManager;
	
	/**
	*	Represents a locale with additional configuration
	*	information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class ConfigurationLocale extends Locale
		implements IConfigurationLocale {
			
		private var _resources:IResourceManager;
		private var _parent:ILocaleManager;
		private var _prefix:String;
		
		/**
		*	Creates a <code>ConfigurationLocale</code> instance.
		*/
		public function ConfigurationLocale()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parent():ILocaleManager
		{
			return _parent;
		}
		
		public function set parent( manager:ILocaleManager ):void
		{
			_parent = manager;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get resources():IResourceManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceManager ):void
		{
			_resources = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get prefix():String
		{
			if( _prefix == null )
			{
				return this.lang + "-" + this.country;
			}
			
			return _prefix;
		}
		
		public function set prefix( prefix:String ):void
		{
			_prefix = prefix;
		}
	}
}