package com.ffsys.io.loaders.responder {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	
	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	Decorates classes that respond to ILoader events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public class LoadResponderDecorator extends EventDispatcher
		implements ILoadResponderDecorator {
			
		private var _decorated:ILoadResponderDecorator;
		private var _responder:ILoadResponder;
		
		public function LoadResponderDecorator( decorated:ILoadResponderDecorator )
		{
			super();
			
			if( !decorated )
			{
				throw new Error(
					"You must instantiate LoadResponderDecorator with a reference " +
					"to the ILoadResponderDecorator that is being decorated." );
			}
			
			_decorated = decorated;
		}
		
		public function set responder( val:ILoadResponder ):void
		{
			_responder = val;
		}
		
		public function get responder():ILoadResponder
		{
			return _responder;
		}
		
		public function addResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null,
			filters:Array = null ):void
		{
			if( !responder )
			{
				responder = this.responder;
			}			
			
			if( dispatcher )
			{
				
				if( responder )
				{
					
					//trace( "Has filters : " + filters );
					
					//trace( "Add responder listeners to dispatcher : " + dispatcher );
					//trace( "Add responder listeners to responder : " + responder );
					
					if( !filters ||
						filters && !( ArrayUtils.contains( filters, LoadStartEvent.LOAD_START ) ) )
					{
						//trace( "Add load start responder" );
						dispatcher.addEventListener(
							LoadStartEvent.LOAD_START, responder.resourceLoadStart, false, 0, true );
					}
					
					
					if( !filters ||
						filters && !( ArrayUtils.contains( filters, LoadProgressEvent.LOAD_PROGRESS ) ) )
					{
						dispatcher.addEventListener(
							LoadProgressEvent.LOAD_PROGRESS, responder.resourceLoadProgress, false, 0, true );
					}
					
					if( !filters ||
					 	filters && !( ArrayUtils.contains( filters, LoadEvent.DATA ) ) )
					{
						dispatcher.addEventListener(
							LoadEvent.DATA, responder.resourceLoaded, false, 0, true );
					}
					
					if( !filters ||
						filters && !( ArrayUtils.contains( filters, ResourceNotFoundEvent.RESOURCE_NOT_FOUND ) ) )
					{					
						dispatcher.addEventListener(
							ResourceNotFoundEvent.RESOURCE_NOT_FOUND, responder.resourceNotFoundHandler, false, 0, true );
					}
				}
			
				dispatcher.addEventListener(
					ResourceNotFoundEvent.RESOURCE_NOT_FOUND, cleanupResponderListeners, false, 0, true );
				dispatcher.addEventListener(
					LoadEvent.DATA, cleanupResponderListeners, false, 0, true );
				
				dispatcher.addEventListener(
					ResourceNotFoundEvent.RESOURCE_NOT_FOUND, _decorated.cleanupResponderListeners, false, 0, true );
				dispatcher.addEventListener(
					LoadEvent.DATA, _decorated.cleanupResponderListeners, false, 0, true );				
			}
		}		
		
		public function removeResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null ):void
		{
			if( !responder )
			{
				responder = this.responder;
			}
			
			if( dispatcher )
			{
				if( responder )
				{
					dispatcher.removeEventListener( LoadStartEvent.LOAD_START, responder.resourceLoadStart );
					dispatcher.removeEventListener( LoadProgressEvent.LOAD_PROGRESS, responder.resourceLoadProgress );
					dispatcher.removeEventListener( LoadEvent.DATA, responder.resourceLoaded );
					dispatcher.removeEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, responder.resourceNotFoundHandler );
				}
			
				dispatcher.removeEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, cleanupResponderListeners );
				dispatcher.removeEventListener( LoadEvent.DATA, cleanupResponderListeners );
				
				dispatcher.removeEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, _decorated.cleanupResponderListeners );
				dispatcher.removeEventListener( LoadEvent.DATA, _decorated.cleanupResponderListeners );				
			}
		}
			
		public function cleanupResponderListeners( event:ILoadEvent ):void
		{
			Event( event ).target.removeEventListener( Event( event ).type, cleanupResponderListeners );
			removeResponderListeners( event.loader );
		}
		
		/*
		*	ILoadResponder implementation	
		*/
		
		public function resourceNotFoundHandler( event:ResourceNotFoundEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadStart( event:LoadStartEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadProgress( event:LoadProgressEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoaded( event:ILoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadComplete( event:LoadCompleteEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
	}
}