package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderElement;	
	import com.ffsys.io.loaders.types.PropertiesLoader;
	
	import com.ffsys.utils.properties.IProperties;
	import com.ffsys.utils.properties.PrimitiveProperties;
	
	/**
	*	Encapsulates a collection of settings files.
	* 
	* 	These files encapsulate arbitrary settings for the application
	* 	loaded from property files and allow the simple types string,
	* 	boolean, number, and array.
	* 
	* 	Settings provide a mechanism for easily configuring simple properties where
	* 	the data does not fall into any neat taxonomy. An example might be
	* 	an application level setting that dictates a mode for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	dynamic public class SettingsCollection extends PropertiesCollection {
		
		/**
		*	Creates a <code>SettingsCollection</code> instance.
		*/
		public function SettingsCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			//ensure our loader uses a primitive properties implementation
			var loader:ILoader = ILoader( super.getLoader( request ) );
			var properties:IProperties = new PrimitiveProperties();
			PropertiesLoader( loader ).properties = properties;
			return loader;
		}
	}
}