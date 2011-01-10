package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.BeanXmlParser;	
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.types.ParserAwareXmlLoader;
	import com.ffsys.io.loaders.types.IParserAwareXmlLoader;
	
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.ui.dom.*;	
	
	import com.ffsys.utils.substitution.Binding;
	
	/**
	*	Responsible for loading the runtime view definition document
	*	and it's dependencies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeLoader extends EventDispatcher
		implements IRuntimeLoader {
			
		private var _queue:ILoaderQueue;
		private var _loader:IParserAwareXmlLoader;
		private var _parser:IRuntimeParser;
		
		/**
		*	Creates a <code>RuntimeLoader</code> instance.	
		*/
		public function RuntimeLoader()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get document():IDocument
		{
			if( this.parser != null )
			{
				return this.parser.runtime;
			}
			return null;
		}
		
		/**
		*	Gets the loader used to load the definition for the view.	
		*/
		public function get loader():IParserAwareXmlLoader
		{
			return _loader;
		}
		
		/**
		* 	The parser to use for the runtime document.
		*/
		public function get parser():IRuntimeParser
		{
			if( _parser == null )
			{
				_parser = new RuntimeParser();
			}
			return _parser;
		}
		
		public function set parser( value:IRuntimeParser ):void
		{
			_parser = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLoaderQueue(
			request:URLRequest,
			parent:DisplayObjectContainer = null,
			... bindings ):ILoaderQueue
		{
			//clean any existing queue
			if( _queue )
			{
				_queue.close();
				//_loader.destroy();
				removeLoaderListeners( _queue );
				_queue = null;
			}
			
			_queue = new LoaderQueue();
			
			_loader = new ParserAwareXmlLoader( request );
			_loader.parser = this.parser;

			bindings.unshift( this.document );
			this.parser.addDocumentBindings.apply( this.parser, bindings );

			//TODO: add binding for the stage dimensions
			
			_loader.root = document;
			
			if( parent != null )
			{
				parent.addChild( DisplayObject( document ) );
			}
			
			_queue.addLoader( _loader );

			addLoaderListeners( _queue );
			
			return _queue;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load():void
		{
			if( _queue == null )
			{
				throw new Error( "Cannot load a runtime with a null loader queue." );
			}
			
			_queue.load();
		}
		
		private function addLoaderListeners( loader:ILoaderElement ):void
		{
			if( loader )
			{
				loader.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_START,
					loadStart, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress, false, 0, false );

				loader.addEventListener(
					LoadEvent.DATA,
					itemLoaded, false, 0, false );
					
				loader.addEventListener(
					LoadEvent.LOAD_COMPLETE,
					loadComplete, false, 0, false );				
			}
		}
		
		private function removeLoaderListeners( loader:ILoaderElement ):void
		{
			if( loader )
			{
				loader.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );

				loader.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );

				loader.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );

				loader.removeEventListener(
					LoadEvent.DATA,
					itemLoaded );
					
				loader.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					loadComplete );					
			}
		}
		
		/**
		*	@private	
		*/
		private function resourceNotFound(
			event:LoadEvent ):void
		{	
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function loadStart( event:LoadEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function loadProgress( 
			event:LoadEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function itemLoaded( event:LoadEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/
		private function loadComplete(
			event:LoadEvent ):void
		{
			removeLoaderListeners( _queue );
			dispatchEvent( event );
		}
	}
}