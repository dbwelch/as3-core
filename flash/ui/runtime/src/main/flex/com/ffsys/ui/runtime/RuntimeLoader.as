package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoaderElement;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.types.ParserAwareXmlLoader;
	import com.ffsys.io.loaders.types.IParserAwareXmlLoader;
	
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
			
		private var _document:IDocument;
		private var _loader:IParserAwareXmlLoader;
		
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
		*	Gets the loader used to load the definition for the view.	
		*/
		public function get loader():IParserAwareXmlLoader
		{
			return _loader;
		}
		
		/**
		*	@inheritDoc
		*/
		public function load(
			request:URLRequest,
			parent:DisplayObjectContainer,
			...bindings ):void
		{
			if( !parent )
			{
				throw new Error(
					"You must specify a parent display object when loading a runtime view." );
			}
			
			if( !parent.stage )
			{
				throw new Error(
					"The parent display object must be on the stage when loading a runtime view." );
			}
			
			//clean any existing loader
			if( _loader )
			{
				_loader.close();
				//_loader.destroy();
				removeLoaderListeners( _loader );
				_loader = null;
			}
			
			_loader = new ParserAwareXmlLoader();
			_loader.parser = new RuntimeParser();
			
			if( bindings.length > 0 )
			{
				var binding:Object = null;
				for( var i:int = 0;i < bindings.length;i++ )
				{
					binding = bindings[ i ];
					trace("RuntimeLoader::get loader()", "ADDING BINDING: " , binding );
					
					for( var z:String in binding )
					{
						trace("RuntimeLoader::get loader()", z, binding[z] );
					}
					
					_loader.parser.interpreter.bindings.addBinding(
						new Binding( Runtime.DOCUMENT_BINDING + "_" + i, binding ) );
				}
			}
			
			_document = new Document();
			_loader.root = document;
			parent.addChild( DisplayObject( document ) );
			
			//trace("RuntimeLoader::load(), ", document.parent, document.stage );
			
			addLoaderListeners( _loader );
			_loader.load( request );
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
			dispatchEvent( event );
		}
	}
}