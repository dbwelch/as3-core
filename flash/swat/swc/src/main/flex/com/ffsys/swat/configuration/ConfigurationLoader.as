package com.ffsys.swat.configuration {

	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceElement;
	import com.ffsys.io.loaders.types.ParserAwareXmlLoader;
	
	/**
	*	Preloads the application configuration <code>XML</code> document.
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
		override public function set resource( resource:IResourceElement ):void
		{
			if( resource != null && resource is IResource )
			{
				_configuration = IConfiguration( IResource( resource ).data );
			}
			super.resource = resource;
		}
	}
}