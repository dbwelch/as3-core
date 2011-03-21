package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoaderElement;
	import com.ffsys.io.loaders.types.SoundLoader;
	
	/**
	*	Encapsulates a collection of sound files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	dynamic public class SoundCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>SoundCollection</code> instance.
		*/
		public function SoundCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoaderElement
		{
			return new SoundLoader( request );
		}
	}
}