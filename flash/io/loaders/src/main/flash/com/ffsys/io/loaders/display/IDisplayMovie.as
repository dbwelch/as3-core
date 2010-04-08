package com.ffsys.io.loaders.display {
	
	import flash.display.Loader;
	import flash.display.Sprite;
	
	import com.ffsys.io.core.IUnload;
	
	/**
	*	Describes the contract for instances that
	*	contain a loaded swf movie and be
	*	added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public interface IDisplayMovie
		extends IAbstractDisplay,
		 		IUnload {
		
		/**
		*	The uniform resource indicator used
		*	to load the swf movie.	
		*/
		function set uri( val:String ):void;
		function get uri():String;
		
		/**
		*	The total bytes for the loaded swf movie.	
		*/
		function set bytesTotal( val:uint ):void;
		function get bytesTotal():uint;			
		
		/**
		*	The <code>Loader</code> used to load
		*	the swf movie.	
		*/
		function set loader( val:Loader ):void;
		function get loader():Loader;
		
		/**
		*	A reference to the main root <code>Sprite</code>
		*	instance within the loaded swf movie.	
		*/
		function get application():Sprite;
	}
}