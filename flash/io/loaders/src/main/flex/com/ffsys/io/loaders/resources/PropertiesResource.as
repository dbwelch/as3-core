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
		
		private var _properties:IProperties;
		
		/**
		*	Creates a <code>PropertiesResource</code> instance.
		*	
		*	@param data The data for the resource.
		*	@param uri The URI the resource was loaded from.
		*	@param bytesTotal The total number of bytes for the
		*	resource.
		*/
		public function PropertiesResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
			_properties = new Properties();
			_properties.parse( data as String );
		}
		
		/**
		*	The properties encapsulated by this resource.
		*/
		public function get properties():IProperties
		{
			return _properties;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function destroy():void
		{
			super.destroy();
			_properties = null;
		}		
	}
}