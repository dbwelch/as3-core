package com.ffsys.io.loaders.display {
	
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;	
	
	/**
	*	Describes the contract for instances that
	*	contain a loaded video and can be added
	*	to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public interface IDisplayVideo extends IAbstractDisplay {
		
		/**
		*	The duration of the video.	
		*/
		function set duration( val:Number ):void;
		function get duration():Number;		
		
		/**
		*	The <code>NetConnection</code> used to load the video.
		*/
		function set netConnection( val:NetConnection ):void;
		function get netConnection():NetConnection;
		
		/**
		*	The <code>NetStream</code> used to load the video.	
		*/
		function set netStream( val:NetStream ):void;
		function get netStream():NetStream;
		
		/**
		*	The <code>Video</code> instance used to display
		*	the loaded video.	
		*/
		function get video():Video;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function close():void;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function pause():void;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function play( ...args ):void;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function resume():void;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function seek( offset:Number ):void;
		
		/**
		*	Proxy method for the encapsulated <code>NetStream</code>.
		*/
		function togglePause():void;
	}
}