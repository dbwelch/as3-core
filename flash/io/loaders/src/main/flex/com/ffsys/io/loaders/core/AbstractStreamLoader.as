package com.ffsys.io.loaders.core {

	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.core.LoaderClassType;
	
	/**
	*	Abstract super class for instances that can playback a stream
	*	during a load process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.08.2007
	*/
	public class AbstractStreamLoader extends AbstractLoader
		implements IStreamLoader {
			
		/**
		*	@private
		*	
		*	Determines whether this instance is treated in a streaming
		*	manner. If the instance is treated in a streaming manner
		*	the default behaviour of playing back the stream is followed
		*	otherwise the loader attempts to stop playback of the stream
		*	as soon as possible so that the entire stream can be loaded
		*	prior to playback starting.
		*/
		protected var _streaming:Boolean;		
		
		public function AbstractStreamLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			this.streaming = true;
		}
		
		public function set streaming( val:Boolean ):void
		{
			_streaming = val;
		}
		
		public function get streaming():Boolean
		{
			return _streaming;
		}
	}
}