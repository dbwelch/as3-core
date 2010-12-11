package com.ffsys.io.loaders.responder {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	/**
	*	Decorates implementations that respond to load events.
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
		
		/**
		* 	Creates a <code>LoadResponderDecorator</code> instance.
		* 
		* 	@param decorated The implementation being decorated.
		*/
		public function LoadResponderDecorator(
			decorated:ILoadResponderDecorator )
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
		
		/**
		* 	@inheritDoc
		*/
		public function get responder():ILoadResponder
		{
			return _responder;
		}		
		
		public function set responder( val:ILoadResponder ):void
		{
			_responder = val;
		}
		
		/**
		* 	@inheritDoc
		*/
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
		
		/**
		* 	@inheritDoc
		*/
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
		
		/**
		* 	@inheritDoc
		*/
		public function cleanupResponderListeners( event:LoadEvent ):void
		{
			event.target.removeEventListener( event.type, cleanupResponderListeners );
			removeResponderListeners( event.loader );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceNotFoundHandler( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoadStart( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoadProgress( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoaded( event:LoadEvent ):void
		{
			//
			_decorated.dispatchEvent( event as Event );
		}
		
		/**
		* 	@inheritDoc
		*/
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