package com.ffsys.io.loaders.display {
	
	import flash.display.Loader;	
	import flash.events.IEventDispatcher;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import com.ffsys.core.IDestroy;
	
	/**
	*	Abstract interface for loaded assets that
	*	can be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public interface IAbstractDisplay
		extends IDestroy,
				IEventDispatcher {
		
		/*
		function loadBytes(
			bytes:ByteArray,
			context:LoaderContext = null ):void;
		*/
		
		/*
		function set loader( val:Loader ):void;
		function get loader():Loader;
		*/
		
		//function get loader():Loader;
	}
	
}
