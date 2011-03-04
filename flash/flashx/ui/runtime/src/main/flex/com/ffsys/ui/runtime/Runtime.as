package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Encapsulates constants that represent binding names.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class Runtime extends Object {
		
		/**
		* 	The binding namespace used when parsing runtime 
		* 	view xml documents.
		*/
		public static const BINDING:String = "binding";
		
		/**
		* 	The binding used when iterating over view elements.
		*/
		public static const ITERATE_BINDING:String = "it";
	}
}