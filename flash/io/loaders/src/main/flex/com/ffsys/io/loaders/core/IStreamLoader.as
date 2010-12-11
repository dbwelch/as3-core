package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for loaders that can behave
	*	in a streaming manner.
	* 
	* 	Although all load processes are essentially streams
	* 	this contract applies to the load processes that
	* 	can playback during a load operation such as sounds
	* 	and video.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2007
	*/
	public interface IStreamLoader extends ILoader {
		
		/**
		* 	Indicates whether this loader should behave in a streaming
		* 	manner and allow playback before the entire file has loaded.
		*/
		function set streaming( val:Boolean ):void;
		function get streaming():Boolean;
	}
}