package com.ffsys.swat.view {
	
	import flash.display.Sprite;	
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.core.ResourceLoadPhase;
	
	/**
	*	View for the application preload sequence.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class DefaultApplicationPreloadView extends Sprite
		implements IApplicationPreloadView {
		
		/**
		*	Creates an <code>DefaultApplicationPreloadView</code> instance.
		*/
		public function DefaultApplicationPreloadView()
		{
			super();			
		}
		
		/**
		*	@inheritDoc
		*/	
		public function created():void
		{
			//
		}
		
		/**
		*	@inheritDoc	
		*/
		public function code( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function resourceNotFound( event:RslEvent ):void
		{
			throw new Error(
				"The requested runtime resource '" +
			 		event.uri + "' could not be found." );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function phase( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
	
		/**
		*	@inheritDoc
		*/
		public function complete( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function resource( event:RslEvent ):void
		{	
			if( event.type == RslEvent.RESOURCE_NOT_FOUND )
			{
				resourceNotFound( event );
				return;
			}
			
			//trace("DefaultApplicationPreloadView::resource()", event.preloader.phase );
					
			switch( event.preloader.phase )
			{
				case ResourceLoadPhase.CONFIGURATION_PHASE:
					configuration( event );
					break;				
				case ResourceLoadPhase.MESSAGES_PHASE:
					message( event );
					break;
				case ResourceLoadPhase.ERRORS_PHASE:
					error( event );
					break;
				case ResourceLoadPhase.SETTINGS_PHASE:
					setting( event );
					break;				
				case ResourceLoadPhase.FONTS_PHASE:
					font( event );
					break;
				case ResourceLoadPhase.RSLS_PHASE:
					rsl( event );
					break;
				case ResourceLoadPhase.BEANS_PHASE:
					bean( event );
					break;
				case ResourceLoadPhase.CSS_PHASE:
					css( event );
					break;
				case ResourceLoadPhase.XML_PHASE:
					xml( event );
					break;
				case ResourceLoadPhase.TEXT_PHASE:
					text( event );
					break;					
				case ResourceLoadPhase.IMAGES_PHASE:
					image( event );
					break;
				case ResourceLoadPhase.SOUNDS_PHASE:
					sound( event );
					break;	
			}
		}
		
		
		/**
		*	@inheritDoc
		*/
		protected function configuration( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function setting( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}		
		
		/**
		*	@inheritDoc
		*/
		protected function message( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}		
		
		/**
		*	@inheritDoc
		*/
		protected function error( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}		
		
		/**
		*	@inheritDoc
		*/
		protected function rsl( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function bean( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}		
		
		/**
		*	@inheritDoc
		*/
		protected function css( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function xml( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function text( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function font( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function image( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		protected function sound( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		public function finished( event:RslEvent ):void
		{
			debug( event.preloader.phase, event );
		}
		
		/**
		* 	@private
		*/
		private function debug( phase:String, event:RslEvent ):void
		{
			trace("Loading: ",
				phase,
				event.type,
				event.uri != null ? event.uri : phase,
				event.bytesLoaded,
				event.bytesTotal,
				int( event.percent ) + "%" );
		}
	}
}