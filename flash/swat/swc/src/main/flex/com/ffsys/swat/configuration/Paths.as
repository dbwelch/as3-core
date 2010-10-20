package com.ffsys.swat.configuration
{
	import com.ffsys.swat.configuration.rsls.IRuntimeResource;
	import com.ffsys.swat.configuration.rsls.IResourceManagerAware;
	
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	* 	Encapsulates global paths for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.10.2010
	*/
	public class Paths extends Object
		implements IPaths
	{
		private var _parent:IConfiguration;
		private var _absolute:Boolean = false;
		private var _base:String = "";
		private var _prefix:String = "assets/";
		private var _common:String = "common/";
		private var _locales:String = "locales/";
		
		//private var _extensions:Object = new Object();
		
		/**
		* 	Creates a <code>Paths</code> instance.
		*/
		public function Paths()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parent():IConfiguration
		{
			return _parent;
		}
		
		public function set parent( parent:IConfiguration ):void
		{
			_parent = parent;
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
		public function get base():String
		{
			return _base;
		}
		
		public function set base( base:String ):void
		{
			_base = base;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get prefix():String
		{
			return _prefix;
		}

		public function set prefix( prefix:String ):void
		{
			_prefix = prefix;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get common():String
		{
			return _common;
		}

		public function set common( common:String ):void
		{
			_common = common;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get locales():String
		{
			return _locales;
		}

		public function set locales( locales:String ):void
		{
			_locales = locales;
		}			
		
		/**
		* 	@inheritDoc
		*/
		public function getTranslatedPath( resource:IRuntimeResource ):String
		{
			if( !resource )
			{
				throw new Error( "Cannot get the translated path from a null resource." );
			}
			
			var output:String = base + prefix;
			
			//if we are globally or individually flagged as absolute
			//we always load using the raw url
			if( this.absolute || resource.absolute )
			{
				return output + resource.url;
			}
			
			var manager:IResourceManagerAware = getResourceManagerAware( resource );

			if( manager is ILocaleManager )
			{
				output += common;
			}else if( manager is IConfigurationLocale )
			{
				output += locales + IConfigurationLocale( manager ).prefix + "/";
			}
			
			output += resource.url;
			
			return output;
		}

		/**
		* 	@private
		*/
		private function getResourceManagerAware(
			resource:IRuntimeResource ):IResourceManagerAware
		{
			var manager:IResourceManagerAware = null;
			
			if( resource.parent
			 	&& resource.parent.parent
				&& resource.parent.parent.parent )
			{
				manager = resource.parent.parent.parent;
			}
			
			return manager;
		}
	}
}