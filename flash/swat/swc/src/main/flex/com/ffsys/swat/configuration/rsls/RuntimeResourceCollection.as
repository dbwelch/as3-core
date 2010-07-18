package com.ffsys.swat.configuration.rsls {

	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	/**
	*	Abstract super class for configuration collections
	*	that encapsulate a set of runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	dynamic public class RuntimeResourceCollection extends Array
		implements IRuntimeResourceCollection {
			
		/**
		*	@private	
		*/
		protected var _queue:ILoaderQueue;
		
		/**
		*	Creates an <code>RuntimeResourceCollection</code> instance.
		*/
		public function RuntimeResourceCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue():ILoaderQueue
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
			
			return _queue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLoader( request:URLRequest ):ILoader
		{
			throw new Error(
				"You must specify the loader type in your concrete implementation." );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( value is IRuntimeResource )
			{
				//store the library reference
				this.push( IRuntimeResource( value ) );
			}
		}
	}
}