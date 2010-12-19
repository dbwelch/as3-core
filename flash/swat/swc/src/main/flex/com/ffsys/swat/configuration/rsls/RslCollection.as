package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.MovieLoader;
	
	/**
	*	Encapsulates a collection of runtime shared libraries.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	dynamic public class RslCollection extends ResourceCollection {
		
		/**
		*	Creates a <code>RslCollection</code> instance.
		*/
		public function RslCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new MovieLoader( request );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getLoaderQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			var lib:RuntimeSharedLibrary = null;
			var request:URLRequest = null;
			var loader:ILoader = null;
			
			for( var i:int = 0;i < this.length;i++ )
			{
				lib = RuntimeSharedLibrary( this[ i ] );
				request = new URLRequest( lib.getTranslatedPath() );
				loader = getLoader( request );

				if( lib.trusted )
				{
					MovieLoader( loader ).context =
						new LoaderContext( false, ApplicationDomain.currentDomain );
				}
				
				initializeLoader( loader, lib );		
				queue.addLoader( loader );
			}
			return queue;
		}
	}
}