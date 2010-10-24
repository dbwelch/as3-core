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
	dynamic public class ResourceCollection extends Array
		implements IResourceCollection {
			
		/**
		*	@private	
		*/
		protected var _queue:ILoaderQueue;
		
		private var _parent:IResourceManager;
		
		/**
		*	Creates an <code>ResourceCollection</code> instance.
		*/
		public function ResourceCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parent():IResourceManager
		{
			return _parent;
		}
		
		public function set parent( manager:IResourceManager ):void
		{
			_parent = manager;
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
					request = new URLRequest( lib.getTranslatedPath() );
					loader = getLoader( request );
					initializeLoader( loader, lib );
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
		*	Performs initialization of loaders as they are
		*	created.
		*	
		*	@param loader The loader to initialize from 	
		*/
		protected function initializeLoader(
			loader:ILoader, resource:IRuntimeResource ):void
		{
			if( resource.id )
			{
				loader.id = resource.id;
			}
		}
		
		/**
		*	@private
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