package com.ffsys.io.loaders.resources {
	
	import flash.text.StyleSheet;
	
	/**
	*	Represents a loaded resource that is a css style sheet.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class StylesheetResource extends AbstractResource {
		
		/**
		*	Creates a <code>StylesheetResource</code> instance.	
		*	
		*	@param data The resource data.
		*	@param uri The uri the resource was loaded from.
		*	@param bytesTotal The total number of bytes.
		*/
		public function StylesheetResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		*	Gets the style sheet associated with
		*	this resource.	
		*/
		public function get styleSheet():StyleSheet
		{
			return StyleSheet( this.data );
		}
	}
}