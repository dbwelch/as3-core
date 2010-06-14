package com.ffsys.swat.view {
	
	import flash.display.Sprite;
	
	import com.ffsys.swat.events.RslEvent;
	
	/**
	*	View for the application preload sequence.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class ApplicationPreloadView extends Sprite
		implements IApplicationPreloadView {
		
		/**
		*	Creates an <code>ApplicationPreloadView</code> instance.
		*/
		public function ApplicationPreloadView()
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
			//
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
		*	@inheritDoc
		*/
		public function configuration( event:RslEvent ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function rsl( event:RslEvent ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function font( event:RslEvent ):void
		{
			//
		}	
		
		/**
		*	@inheritDoc
		*/
		public function complete( event:RslEvent ):void
		{
			//
		}
	}
}