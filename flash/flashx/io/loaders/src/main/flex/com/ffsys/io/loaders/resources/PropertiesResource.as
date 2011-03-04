package com.ffsys.io.loaders.resources {
	
	import com.ffsys.utils.properties.IProperties;
	import com.ffsys.utils.properties.Properties;
	
	/**
	*	Represents a loaded resource that is a collection
	*	of properties.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class PropertiesResource extends AbstractResource {
		
		/**
		* 	Creates a <code>PropertiesResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		* 	@param properties A properties implementation to use.
		*/
		public function PropertiesResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0,
			properties:IProperties = null )
		{
			if( properties == null )
			{
				properties = new Properties();
			}
			properties.parse( data as String );
			super( properties, uri, bytesTotal );
		}
		
		/**
		*	The properties encapsulated by this resource.
		*/
		public function get properties():IProperties
		{
			return ( data as IProperties );
		}
	}
}