/**
*	A library for runtime dependency injection.
*
*	The beans retrieved at runtime can be declared
*	as <code>CSS</code> or <code>XML</code>.
*/
package com.ffsys.ioc {
	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.IResource;
	
	import com.ffsys.utils.substitution.*;
	
	/**
	*	Responsible for managing a collection of bean documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class BeanManager extends EventDispatcher
		implements IBeanManager {
		
		private var _beanDocuments:Vector.<BeanDocumentEntry> = new Vector.<BeanDocumentEntry>();
		
		/**
		* 	@private
		*/
		protected var _document:IBeanDocument;
		
		//TODO: refactor the dependency queue to be a nested queue
		private var _queue:ILoaderQueue;
		private var _dependencyQueue:ILoaderQueue;
		
		/**
		*	Creates a <code>BeanManager</code> instance.
		*/
		public function BeanManager()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get document():IBeanDocument
		{
			if( _document == null )
			{
				_document = BeanDocumentFactory.create();
			}
			
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get bindings():IBindingCollection
		{
			return this.document.bindings;
		}
		
		public function set bindings( value:IBindingCollection ):void
		{
			this.document.bindings = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function addBeanDocument( request:URLRequest ):IBeanDocument
		{	
			if( request )
			{
				var entry:BeanDocumentEntry = new BeanDocumentEntry(
					request, this.document );
				_beanDocuments.push( entry );
			}
			return document;
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeBeanDocument(
			request:URLRequest ):Boolean
		{
			if( request )
			{
				var entry:BeanDocumentEntry = null;
				for( var i:int = 0;i < _beanDocuments.length;i++ )
				{
					entry = _beanDocuments[ i ];
					if( entry.request == request || entry.request.url == request.url )
					{
						_beanDocuments.splice( i, 1 );
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getBean( beanName:String ):Object
		{
			return this.document.getBean( beanName );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get beanNames():Array
		{
			return this.document.beanNames;
		}

		/**
		*	@inheritDoc
		*/
		public function load():ILoaderQueue
		{
			if( _queue )
			{
				_queue.destroy();
			}
			
			_queue = new LoaderQueue();
			
			var loader:BeanLoader = null;
			var entry:BeanDocumentEntry = null;
			for each( entry in _beanDocuments )
			{
				loader = new BeanLoader( entry.request );
				loader.document = this.document;
				loader.addEventListener( LoadEvent.DATA, itemLoaded );
				_queue.addLoader( loader );
			}
			
			//_queue.addEventListener( LoadEvent.LOAD_COMPLETE, documentsLoaded );
			_queue.load();
			
			return _queue;
		}
		
		/**
		* 	Destroys this manager implementation.
		*/
		public function destroy():void
		{
			//TODO: close any loading queue
			
			//TODO: destroy composite bindings
			
			if( _document )
			{
				_document.destroy();
			}
			
			_document = null;
			_beanDocuments = null;
		}
		
		
		private function itemLoaded( event:LoadEvent ):void
		{
			if( this.document.files
				&& this.document.files.length )
			{
				var dependencies:ILoaderQueue = this.document.dependencies;
				dependencies.addEventListener( LoadEvent.DATA, resolveFileDependency );
				dependencies.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, resolveFileDependency );
				dependencies.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );				

				//inject the dependency queue into the main loader queue
				_queue.insertLoaderAt( dependencies, _queue.index + 1 );
			}
		}
		
		/**
		*	@private
		*/
		private function resolveFileDependency( event:LoadEvent ):void
		{
			var dependency:BeanFileDependency = event.loader.customData as BeanFileDependency;
			if( dependency )
			{
				//we change the bean property sent to be resolved
				//based upon whether the resource was found
				//when it is found the data encapsulated by the resource
				//is passed to resolve otherwise it is the loader that attempted
				//to load the file
				dependency.resolve(
					document,
					null,
					event.type == LoadEvent.RESOURCE_NOT_FOUND ? event.loader : IResource( event.resource ).data );
			}
		}
		
		/**
		*	@private
		*/
		private function dependenciesLoaded( event:LoadEvent ):void
		{
			var dependencies:ILoaderQueue = this.document.dependencies;
			dependencies.removeEventListener( LoadEvent.DATA, resolveFileDependency );
			dependencies.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, resolveFileDependency );
			dependencies.removeEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
		}
	}
}

import flash.net.URLRequest;
import com.ffsys.ioc.IBeanDocument;

class BeanDocumentEntry extends Object {

	/**
	*	The url request for the entry.
	*/
	public var request:URLRequest;

	/**
	*	The bean document for the entry.
	*/
	public var document:IBeanDocument;

	/**
	*	Creates a <code>BeanDocumentEntry</code> instance.
	*
	*	@param request The url request.
	*	@param document The bean document implementation.
	*/
	public function BeanDocumentEntry(
		request:URLRequest = null,
		document:IBeanDocument = null )
	{
		super();
		this.request = request;
		this.document = document;
	}
}