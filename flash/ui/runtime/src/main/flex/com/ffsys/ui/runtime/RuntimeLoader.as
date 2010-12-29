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
		private var _document:IDocument;
		private var _loader:IParserAwareXmlLoader;
		private var _parser:IParser;
		private var _components:IBeanDocument;
		
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
			return _document;
		}
		
		/**
		* 	The bean document containing component definitions.
		*/
		public function get components():IBeanDocument
		{
			if( _components == null )
			{
				_components = new RuntimeComponentDocument();
			}
			return _components;
		}
		
		public function set components( value:IBeanDocument ):void
		{
			_components = value;
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
		public function get parser():IParser
		{
			if( _parser == null )
			{
				trace("RuntimeLoader::get parser()", this.components );
				_parser = new RuntimeParser( this.components );
			}
			return _parser;
		}
		
		public function set parser( value:IParser ):void
		{
			_parser = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function load(
			request:URLRequest,
			parent:DisplayObjectContainer = null,
			... bindings ):void
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
			
			if( _document )
			{
				_document.destroy();
			}
			
			_document = new Document();			
			
			if( bindings.length > 0 )
			{
				var binding:Object = null;
				for( var i:int = 0;i < bindings.length;i++ )
				{
					binding = bindings[ i ];
					for( var z:String in binding )
					{
						document.binding[ z ] = binding[ z ];
					}
				}
				
				_loader.parser.interpreter.bindings.addBinding(
					new Binding( Runtime.BINDING, document.binding ) );
			}
			
			//TODO: add binding for the stage dimensions
			
			_loader.root = document;
			
			if( parent != null )
			{
				parent.addChild( DisplayObject( document ) );
			}
			
			_queue.addLoader( _loader );

			addLoaderListeners( _queue );
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
			trace("RuntimeLoader::itemLoaded()", "LOAD COMPLETE" );
			dispatchEvent( event );
		}
	}
}