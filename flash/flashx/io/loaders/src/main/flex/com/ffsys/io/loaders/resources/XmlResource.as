package com.ffsys.io.loaders.resources {

	/**
	*	Represents a loaded resource that is an <code>XML</code> document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class XmlResource extends AbstractResource {
		
		/**
		* 	Creates an <code>XmlResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function XmlResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		* 	The data for this resource coerced to <code>XML</code>.
		*/		
		public function get xml():XML
		{
			return XML( this.data );
		}
	}
}