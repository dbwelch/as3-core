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
	*	Responsible for loading multiple bean files and resolving document level
	* 	dependencies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class BeanManager extends LoaderQueue
		implements IBeanManager {
		
		/**
		* 	@private
		*/
		protected var _document:IBeanDocument;
		
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
				var loader:BeanLoader = new BeanLoader( request );
				loader.document = this.document;
				loader.addEventListener( LoadEvent.DATA, injectDocumentFileDependencies );
				addLoader( loader );
			}
			return document;
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeBeanDocument(
			request:URLRequest ):Boolean
		{
			if( request != null )
			{
				var loader:ILoaderElement = null;
				for( var i:int = 0;i < this.length;i++ )
				{
					loader = getLoaderAt( i );
					if( loader is ILoader
						&& ILoader( loader ).request != null
						&& ILoader( loader ).request.url == request.url )
					{
						removeLoader( loader );
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
		*	A list of all the bean names stored in the document
		* 	used by this bean manager.
		* 
		* 	@return An array of bean names.
		*/
		public function get beanNames():Array
		{
			return this.document.beanNames;
		}

		/**
		*	@inheritDoc
		*/
		public function getLoaderQueue():ILoaderQueue
		{
			close();
			
			//no reference at the moment
			var fileResolver:BeanFileLoadResolver =
				new BeanFileLoadResolver( this.document, this, null );			
			
			return this;
		}
		
		/**
		* 	Destroys this bean manager implementation.
		*/
		override public function destroy():void
		{
			super.destroy();
			_document = null;
		}
		
		private function injectDocumentFileDependencies( event:LoadEvent ):void
		{
			//trace("BeanManager::injectDocumentFileDependencies()", this.document.files.length, event.type );
			
			if( this.document.files
				&& this.document.files.length )
			{
				var dependencies:ILoaderQueue = this.document.dependencies;
				dependencies.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
	
				//inject the document level dependencies queue into this loader queue
				this.insertLoaderAt( dependencies, this.index + 1 );
			}
		}
		
		/**
		*	@private
		*/
		private function dependenciesLoaded( event:LoadEvent ):void
		{
			var dependencies:ILoaderQueue = this.document.dependencies;
			dependencies.removeEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			
			//TODO: clear files stored by the document when document level dependencies have been resolved
			//this.document.files = new Vector.<BeanFileDependency>();
		}
	}
}