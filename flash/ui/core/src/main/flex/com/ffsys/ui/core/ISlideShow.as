package com.ffsys.ui.core
{
	import com.ffsys.core.IStartStop;
	
	/**
	*	Describes the contract for objects that provide a slideshow.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.06.2010
	*/
	public interface ISlideShow
		extends IStartStop
	{
		/**
		* 	Determines whether the slideshow starts automatically.
		*/
		function get automatic():Boolean;
		function set automatic( automatic:Boolean ):void;
		
		/**
		* 	The amount of time to focus on a slideshow item
		* 	before moving to the next item in the slideshow.
		*/
		function get pauseTime():Number;
		function set pauseTime( pauseTime:Number ):void;
		
		/**
		*	Determines whether the slideshow should loop back to the
		* 	beginning when it reaches the end. 
		*/
		function get loops():Boolean;
		function set loops( loops:Boolean ):void;
		
		/**
		* 	Determines whether this slideshow is playing.
		*/
		function get playing():Boolean;
		
		/**
		* 	Determines whether the slideshow has been started.
		* 
		* 	This will be false if the start method has not been
		* 	invoked and true once the start method has been invoked.
		*/
		function get started():Boolean;
		
		/**
		* 	The index of the current item in the slideshow.
		*/
		function get index():uint;
		
		/**
		* 	The number of items in the slideshow.
		*/
		function get length():uint;
		
		/**
		* 	Move to the next item in the slideshow.
		*/
		function next():void;
		
		/**
		* 	Move to the previous item in the slideshow.
		*/
		function previous():void;		
	}
}