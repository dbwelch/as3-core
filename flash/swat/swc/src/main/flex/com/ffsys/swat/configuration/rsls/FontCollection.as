package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.FontLoader;	
	
	/**
	*	Encapsulates a collection of font files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	dynamic public class FontCollection extends RuntimeResourceCollection {
		
		/**
		*	Creates a <code>FontCollection</code> instance.
		*/
		public function FontCollection()
		{
			super();
		}

		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new FontLoader( request );
		}

		/**
		*	@inheritDoc	
		*/
		override public function getLoaderQueue():ILoaderQueue
		{
			if( !_queue )
			{
				_queue = new LoaderQueue();

				var lib:IRuntimeResource = null;
				var request:URLRequest = null;
				var loader:ILoader = null;

				for( var i:int = 0;i < this.length;i++ )
				{
					lib = IRuntimeResource( this[ i ] );
					request = new URLRequest( lib.url );
					loader = getLoader( request );
					_queue.addLoader( loader );
				}
			}

			return super.getLoaderQueue();
		}
	}
}