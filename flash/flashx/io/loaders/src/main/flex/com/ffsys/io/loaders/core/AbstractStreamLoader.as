package com.ffsys.io.loaders.core {

	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	
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
			
		private var _streaming:Boolean = false;
		
		/**
		* 	Creates an <code>AbstractStreamLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function AbstractStreamLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get streaming():Boolean
		{
			return _streaming;
		}

		public function set streaming( val:Boolean ):void
		{
			_streaming = val;
		}
	}
}