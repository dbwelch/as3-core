package com.ffsys.ui.loaders
{
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.IMaskComponent;
	
	/**
	*	Describes the contract for loader components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface ILoaderComponent
		extends ITransitionAwareSlideShow
	{
		/**
		* 	Determines how the loader should respond to content
		* 	that exceeds the preferred dimensions of the loader.
		*/
		function get scaleMode():String;
		function set scaleMode( value:String ):void;
		
		/**
		* 	A preloader implementation that responds to load
		* 	events.
		*/
		function get preloader():IPreloader;
		function set preloader( preloader:IPreloader ):void;		
		
		/**
		* 	Gets the container that holds the loaded runtime asset(s).
		*/
		function get container():IComponent;
		
		/**
		*	The an array of URLs to load the runtime assets from.
		*/
		function get urls():Array;
		function set urls( urls:Array ):void;
		
		/**
		* 	Starts the load process.
		*/
		function load():void;
		
		/**
		* 	Determines whether the contents of this loader
		* 	are masked at the preferred dimensions.
		*/
		function get masked():Boolean;
		function set masked( masked:Boolean ):void;
		
		/**
		* 	Gets the mask component used for the mask
		* 	when this component is configured to be masked.
		*/
		function get masker():IMaskComponent;		
	}
}