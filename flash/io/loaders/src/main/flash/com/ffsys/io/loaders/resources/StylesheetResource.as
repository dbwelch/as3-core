package com.ffsys.io.loaders.resources {
	
	import flash.text.StyleSheet;
	
	import com.ffsys.io.loaders.types.IStylesheetAccess;
	
	/**
	*	Represents a loaded resource that is StyleSheet data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class StylesheetResource extends AbstractResource
		implements IStylesheetAccess {
		
		public function StylesheetResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get stylesheet():StyleSheet
		{
			return StyleSheet( this.data );
		}
		
	}
	
}
