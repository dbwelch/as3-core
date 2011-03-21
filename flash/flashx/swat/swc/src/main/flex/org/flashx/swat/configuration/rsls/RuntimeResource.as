package org.flashx.swat.configuration.rsls {
	
	import org.flashx.swat.configuration.IConfiguration;
	import org.flashx.swat.configuration.IConfigurationElement;	
	import org.flashx.swat.configuration.locale.ILocaleManager;
	import org.flashx.swat.configuration.locale.IConfigurationLocale;
	import org.flashx.swat.configuration.IPaths;	
	
	/**
	*	Represents a runtime resource definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public class RuntimeResource extends Object
		implements IRuntimeResource {
			
		private var _id:String;
		private var _url:String;
		private var _absolute:Boolean = false;
		private var _configuration:IConfigurationElement;
		
		/**
		*	Creates a <code>RuntimeResource</code> instance.
		*/
		public function RuntimeResource()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
				
		/**
		*	@inheritDoc
		*/
		public function get url():String
		{
			return _url;
		}
	
		public function set url( url:String ):void
		{
			_url = url;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get absolute():Boolean
		{
			return _absolute;
		}
		
		public function set absolute( absolute:Boolean ):void
		{
			_absolute = absolute;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}

		public function set configuration(
			configuration:IConfigurationElement ):void
		{
			_configuration = configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getTranslatedPath(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):String
		{
			var output:String = _url;
			
			var configuration:IConfiguration =
				this.configuration as IConfiguration;
			
			//use global paths if necessary
			if( paths == null
				&& configuration != null
				&& configuration.paths != null )
			{
				paths = configuration.paths;
			}
			
			if( paths == null )
			{
				throw new Error(
					"Cannot retrieve a translated resource path with no path configuration." );
			}
			
			var localeSpecific:Boolean = ( locale != null );
			
			//trace("RuntimeResource::getTranslatedPath() (paths/locale/base/url): ", paths, locale, paths.base, this.url );
			
			var parts:Array = [ paths.base ];

			//if we are globally or individually flagged as absolute
			//we always load using the raw url
			if( paths.absolute || this.absolute )
			{
				output = this.url;
			}else{
				//global resources for all locales
				if( !localeSpecific )
				{
					parts.push( paths.common );
					output = paths.join( parts, this.url );
				//locale specific resources
				}else
				{
					output = paths.join( [ paths.getLocalePath( locale ) ], this.url );
				}
			}
			
			//trace("RuntimeResource::getTranslatedPath() translated: ", paths, locale, output );
			return output;
		}
	}
}