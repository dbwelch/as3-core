package com.ffsys.swat.configuration.rsls {

	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;	
	import com.ffsys.io.loaders.core.ILoaderElement;
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
		
		private var _parent:IResourceDefinitionManager;
		
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
		public function get parent():IResourceDefinitionManager
		{
			return _parent;
		}
		
		public function set parent( manager:IResourceDefinitionManager ):void
		{
			_parent = manager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			var lib:IRuntimeResource = null;
			var request:URLRequest = null;
			var loader:ILoaderElement = null;
			for( var i:int = 0;i < this.length;i++ )
			{
				lib = IRuntimeResource( this[ i ] );
				request = new URLRequest( lib.getTranslatedPath() );
				loader = getLoader( request );
				if( loader is ILoader )
				{
					initializeLoader( ILoader( loader ), lib );
				}
				queue.addLoader( loader );
			}
			return queue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLoader( request:URLRequest ):ILoaderElement
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