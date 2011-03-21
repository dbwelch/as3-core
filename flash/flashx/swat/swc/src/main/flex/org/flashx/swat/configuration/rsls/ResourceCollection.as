package org.flashx.swat.configuration.rsls {

	import flash.net.URLRequest;
	
	import org.flashx.io.loaders.core.ILoader;	
	import org.flashx.io.loaders.core.ILoaderElement;
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.io.loaders.core.LoaderQueue;
	
	import org.flashx.swat.configuration.IPaths;	
	import org.flashx.swat.configuration.locale.IConfigurationLocale;	
	
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
			
		private var _id:String;
		
		/**
		*	Creates an <code>ResourceCollection</code> instance.
		*/
		public function ResourceCollection()
		{
			super();
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):ILoaderQueue
		{
			//trace("ResourceCollection::getLoaderQueue()", paths, locale, this.length );
			
			var queue:ILoaderQueue = new LoaderQueue();
			queue.id = this.id;
			queue.customData = this;
			var nested:ILoaderQueue = null;
			var lib:IResourceDefinitionElement = null;
			var resource:IRuntimeResource = null;
			var collection:IResourceCollection = null;
			var request:URLRequest = null;
			var loader:ILoaderElement = null;
			for( var i:int = 0;i < this.length;i++ )
			{
				lib = this[ i ] as IResourceDefinitionElement;
				
				//trace("ResourceCollection::getLoaderQueue() got lib: ", lib );
				
				if( lib is IRuntimeResource )
				{
					resource = IRuntimeResource( lib );
					request = new URLRequest( resource.getTranslatedPath(
						paths, locale ) );
				
					loader = getLoader( request );
					if( loader != null )
					{
						if( loader is ILoader )
						{
							initializeLoader( ILoader( loader ), resource );
						}
						queue.addLoader( loader );
					}
				}else if( lib is IResourceCollection )
				{
					collection = IResourceCollection( lib );
					
					//trace("ResourceCollection::getLoaderQueue()", "FOUND NESTED RESOURCE COLLECTION", this, collection );
					
					nested = collection.getLoaderQueue( paths, locale );
					
					//trace("ResourceCollection::getLoaderQueue()", "FOUND NESTED RESOURCE COLLECTION", nested, nested.length );
					
					if( nested != null
					 	&& !nested.isEmpty() )
					{
						queue.addLoader( nested );
					}
				}
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
			//trace("ResourceCollection::setDeserializedProperty()", name, this.hasOwnProperty( name ) );
			if( this.hasOwnProperty( name ) )
			{
				this[ name ] = value;
			}else if( value is IResourceDefinitionElement )
			{
				//store the library reference
				this.push( IResourceDefinitionElement( value ) );
			}
		}
	}
}