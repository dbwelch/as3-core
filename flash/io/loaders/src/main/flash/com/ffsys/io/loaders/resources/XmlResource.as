package com.ffsys.io.loaders.resources {
	
	import com.ffsys.io.loaders.types.IXmlAccess;

	
	/**
	*	Represents a loaded resource that is XML data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class XmlResource extends AbstractResource
		implements IXmlAccess {
		
		public function XmlResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get xml():XML
		{
			return XML( this.data );
		}
		
	}
	
}
