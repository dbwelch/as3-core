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
	public class StyleSheetResource extends AbstractResource {
		
		/**
		* 	Creates a <code>StyleSheetResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function StyleSheetResource(
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