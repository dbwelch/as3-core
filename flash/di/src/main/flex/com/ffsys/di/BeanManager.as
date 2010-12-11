/**
*	A library for runtime dependency injection.
*
*	The beans retrieved at runtime can be declared
*	as <code>CSS</code> or <code>XML</code>.
*/
package com.ffsys.di {
	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	//import com.ffsys.io.loaders.resources.BeanDocumentResource;
	
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
	public class BeanManager extends BeanDocument
		implements IBeanManager {
			
		private var _queue:ILoaderQueue;
		private var _dependencyQueue:ILoaderQueue;
		private var _beanDocuments:Vector.<BeanDocumentEntry> = new Vector.<BeanDocumentEntry>();
		
		/**
		*	Creates a <code>BeanManager</code> instance.
		*/
		public function BeanManager()
		{
			super();
			this.bindings = new BindingCollection();
		}
		
		/**
		*	@inheritDoc
		*/
		public function addBeanDocument(
			document:IBeanDocument = null,
			request:URLRequest = null ):IBeanDocument
		{
			if( document == null )
			{
				document = BeanDocumentFactory.create();
			}
				
			var entry:BeanDocumentEntry = new BeanDocumentEntry( request, document );
			
			if( request && document )
			{
				//_beanDocuments[ document ] = request;
				
				if( this.bindings )
				{
					if( !document.bindings )
					{
						document.bindings = this.bindings;
					}else{
						for( var i:int = 0;i < this.bindings.getLength();i++ )
						{
							document.bindings.addBinding(
								bindings.getBindingAt( i ) );
						}
					}
				}
			}
			
			_beanDocuments.push( entry );
			return document;
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeBeanDocument(
			document:IBeanDocument ):Boolean
		{
			var entry:BeanDocumentEntry = null;
			for( var i:int = 0;i < _beanDocuments.length;i++ )
			{
				entry = _beanDocuments[ i ];
				if( entry.document == document )
				{
					_beanDocuments.splice( i, 1 );
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBeanDocument( id:String ):IBeanDocument
		{
			if( id )
			{
				var document:IBeanDocument = null;
				var entry:BeanDocumentEntry = null;
				for each( entry in _beanDocuments )
				{
					document = IBeanDocument( entry.document );
					if( id == document.id )
					{
						return document;
					}
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getBean( beanName:String ):Object
		{
			var document:IBeanDocument = null;
			var instance:Object = null;
			var entry:BeanDocumentEntry = null;
			for each( entry in _beanDocuments )
			{
				document = IBeanDocument( entry.document );
				instance = document.getBean( beanName );
				if( instance )
				{
					return instance;
				}
			}
			
			return super.getBean( beanName );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get beanNames():Array
		{
			var output:Array = super.beanNames;
			
			var document:IBeanDocument = null;
			var entry:BeanDocumentEntry = null;
			var beans:Array = null;
			for each( entry in _beanDocuments )
			{
				document = IBeanDocument( entry.document );
				beans = document.beanNames;
				if( beans )
				{
					output = output.concat( beans );
				}
			}
			
			return output;
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
			var document:IBeanDocument = null;
			var entry:BeanDocumentEntry = null;
			for each( entry in _beanDocuments )
			{
				document = IBeanDocument( entry.document );
				loader = new BeanLoader( entry.request );
				loader.document = document;
				
				//TODO: re-implement
				//loader.addEventListener( LoadEvent.DATA, itemLoaded );	
				_queue.addLoader( loader );
			}
			
			_queue.load();
			
			return _queue;
		}
		
		private var _current:IBeanDocument;
		
		/**
		*	@private
		*/
		
		/*
		private function itemLoaded( event:LoadEvent ):void
		{
			_current = IBeanDocument(
				BeanDocumentResource( event.resource ).beanSheet );
				
			//trace("BeanManager::itemLoaded(), ", event.loader, event.loader.id, _current );
			
			if( _current )
			{
				//assign a default id based on the loader id
				if( !_current.id && event.loader && event.loader.id )
				{
					_current.id = event.loader.id;
				}
				
				if( _current.dependencies && _current.dependencies.getLength() > 0 )
				{
					_queue.paused = true;
					_dependencyQueue = _current.dependencies;
					_dependencyQueue.addEventListener( LoadEvent.DATA, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_START, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_PROGRESS, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
					_dependencyQueue.load();
				}
			}
		}
		*/
		
		/**
		*	@private
		*/
		
		/*
		override protected function dependenciesLoaded( event:LoadEvent ):void
		{
			_dependencyQueue.removeEventListener( LoadEvent.DATA, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_START, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_PROGRESS, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, dependencyDispatchProxy );
			
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			
			//resume the main bean queue
			_queue.resume();
			_current = null;
		}
		*/
		
		/**
		*	@private	
		*/
		private function dependencyDispatchProxy( event:LoadEvent ):void
		{
			//proxy the events through the main loader queue
			_queue.dispatchEvent( event );
		}
	}	
}

import flash.net.URLRequest;
import com.ffsys.di.IBeanDocument;

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