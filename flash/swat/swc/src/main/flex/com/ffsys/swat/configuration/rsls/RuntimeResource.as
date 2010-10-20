package com.ffsys.swat.configuration.rsls {
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
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
		private var _parent:IResourceCollection;
		
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
		public function get parent():IResourceCollection
		{
			return _parent;
		}
		
		public function set parent( parent:IResourceCollection ):void
		{
			_parent = parent;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			var config:IConfiguration = null;
			var manager:IResourceManagerAware = null;
			
			if( parent
			 	&& parent.parent
				&& parent.parent.parent )
			{
				manager = this.parent.parent.parent;
			}
			
			//global resources
			if( manager is ILocaleManager )
			{
				config = ILocaleManager( manager ).parent;
				
			//locale specific resources
			}else if( manager is IConfigurationLocale )
			{
				config = IConfigurationLocale( manager ).parent.parent;
			}
			
			return config;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getTranslatedPath():String
		{
			var output:String = _url;
			
			var configuration:IConfiguration = this.configuration;
			
			if( !configuration )
			{
				throw new Error( "Cannot get the translated path for a resource with no configuration." );
			}
			
			if( configuration && !configuration.paths )
			{
				throw new Error( "Cannot get the translated path for a resource with no path configuration." );
			}
			
			if( configuration
				&& configuration.paths )
			{
				output = configuration.paths.getTranslatedPath( this );
			}
			
			return output;
		}
	}
}