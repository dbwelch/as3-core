package com.ffsys.io.loaders.responder {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	
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
						filters && !( contains( filters, LoadEvent.LOAD_START ) ) )
					{
						//trace( "Add load start responder" );
						dispatcher.addEventListener(
							LoadEvent.LOAD_START, responder.resourceLoadStart, false, 0, true );
					}
					
					
					if( !filters ||
						filters && !( contains( filters, LoadEvent.LOAD_PROGRESS ) ) )
					{
						dispatcher.addEventListener(
							LoadEvent.LOAD_PROGRESS, responder.resourceLoadProgress, false, 0, true );
					}
					
					if( !filters ||
					 	filters && !( contains( filters, LoadEvent.DATA ) ) )
					{
						dispatcher.addEventListener(
							LoadEvent.DATA, responder.resourceLoaded, false, 0, true );
					}
					
					if( !filters ||
						filters && !( contains( filters, LoadEvent.RESOURCE_NOT_FOUND ) ) )
					{					
						dispatcher.addEventListener(
							LoadEvent.RESOURCE_NOT_FOUND, responder.resourceNotFoundHandler, false, 0, true );
					}
				}
			
				dispatcher.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND, cleanupResponderListeners, false, 0, true );
				dispatcher.addEventListener(
					LoadEvent.DATA, cleanupResponderListeners, false, 0, true );
				
				dispatcher.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND, _decorated.cleanupResponderListeners, false, 0, true );
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
					dispatcher.removeEventListener( LoadEvent.LOAD_START, responder.resourceLoadStart );
					dispatcher.removeEventListener( LoadEvent.LOAD_PROGRESS, responder.resourceLoadProgress );
					dispatcher.removeEventListener( LoadEvent.DATA, responder.resourceLoaded );
					dispatcher.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, responder.resourceNotFoundHandler );
				}
			
				dispatcher.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, cleanupResponderListeners );
				dispatcher.removeEventListener( LoadEvent.DATA, cleanupResponderListeners );
				
				dispatcher.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, _decorated.cleanupResponderListeners );
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
		
		public function resourceNotFoundHandler( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadStart( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadProgress( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoaded( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		public function resourceLoadComplete( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		/**
		*	@private
		*	
		*	Determines whether an array contains an event type.	
		*	
		*	@param source The source array.
		*	@param type The event type.
		*	
		*	@return Whether the source array contains the event type.
		*/
		private function contains( source:Array, type:String ):Boolean
		{
			return source.indexOf( type ) > -1;
		}
	}
}