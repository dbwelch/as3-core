package com.ffsys.swat.configuration {

	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.XmlResource;
	import com.ffsys.io.loaders.types.ParserAwareXmlLoader;
	
	import com.ffsys.swat.events.ConfigurationEvent;
	
	/**
	*	Preloads the application configuration XML document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.05.2010
	*/
	public class ConfigurationLoader extends ParserAwareXmlLoader {

		private var _configuration:IConfiguration;
		
		/**
		*	Constructs an <code>ConfigurationLoader</code> instance.
		*/
		public function ConfigurationLoader()
		{
			super();
			this.parser = new ConfigurationParser();
			this.root = new Configuration();
		}
		
		/**
		*	Gets the configuation that has been loaded and parsed.	
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set resource( resource:IResource ):void
		{
			if( resource != null )
			{
				_configuration = IConfiguration( resource.data );
			}
			super.resource = resource;
		}
	}
}