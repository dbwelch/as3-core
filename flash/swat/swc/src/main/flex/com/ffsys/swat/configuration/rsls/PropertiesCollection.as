package com.ffsys.swat.configuration.rsls {
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.types.PropertiesLoader;
	
	/**
	*	Encapsulates a collection of property files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	dynamic public class PropertiesCollection extends RuntimeResourceCollection {
		
		/**
		*	Creates a <code>PropertiesCollection</code> instance.
		*/
		public function PropertiesCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getLoader( request:URLRequest ):ILoader
		{
			return new PropertiesLoader( request );
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