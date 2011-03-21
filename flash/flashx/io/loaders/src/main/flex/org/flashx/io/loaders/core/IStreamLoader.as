package org.flashx.io.loaders.core {
	
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
		* 	
		*	When streaming is <code>false</code> the loader attempts
		* 	to stop playback of the stream as soon as possible so
		* 	that the entire stream can be loaded prior to playback starting.
		*/
		function set streaming( val:Boolean ):void;
		function get streaming():Boolean;
	}
}