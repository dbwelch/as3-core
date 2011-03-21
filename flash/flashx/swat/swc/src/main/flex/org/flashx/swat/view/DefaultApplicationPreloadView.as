package org.flashx.swat.view {
	
	import flash.display.Sprite;	
	
	import org.flashx.swat.events.RslEvent;
	import org.flashx.swat.core.ResourceLoadPhase;
	
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
			
		private var _strict:Boolean = true;
		
		/**
		*	Creates an <code>DefaultApplicationPreloadView</code> instance.
		*/
		public function DefaultApplicationPreloadView(
			strict:Boolean = true )
		{
			super();
			this.strict = strict;
		}
		
		/**
		* 	Indicates whether this implementation is running
		* 	in strict mode, the default value is <code>true</code>.
		* 
		* 	When running in strict mode a runtime exception is thrown
		* 	as soon as a resource not found is encountered.
		*/
		public function get strict():Boolean
		{
			return _strict;
		}
		
		public function set strict( value:Boolean ):void
		{
			_strict = value;
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
		public function resourceNotFound( event:RslEvent ):void
		{
			if( this.strict )
			{
				throw new Error(
					"The requested runtime resource '" +
				 		event.uri + "' could not be found." );
			}else{
				debug( event.phase, event );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function phase( event:RslEvent ):void
		{
			debug( event.phase, event );
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
			
			//trace("DefaultApplicationPreloadView::resource()", event.phase );
					
			switch( event.phase )
			{
				case ResourceLoadPhase.CODE_PHASE:
					code( event );
					break;				
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
				case ResourceLoadPhase.COMPONENTS_PHASE:
					component( event );
					break;					
			}
		}
		

		/**
		*	@inheritDoc
		*/
		public function complete( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		public function finished( event:RslEvent ):void
		{
			debug( event.phase, event );
		}		
		
		/**
		*	@private
		*/
		protected function code( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function configuration( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function setting( event:RslEvent ):void
		{
			debug( event.phase, event );
		}		
		
		/**
		*	@private
		*/
		protected function message( event:RslEvent ):void
		{
			debug( event.phase, event );
		}		
		
		/**
		*	@private
		*/
		protected function error( event:RslEvent ):void
		{
			debug( event.phase, event );
		}		
		
		/**
		*	@private
		*/
		protected function rsl( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function bean( event:RslEvent ):void
		{
			debug( event.phase, event );
		}		
		
		/**
		*	@private
		*/
		protected function css( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function xml( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function text( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function font( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function image( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function sound( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		*	@private
		*/
		protected function component( event:RslEvent ):void
		{
			debug( event.phase, event );
		}
		
		/**
		* 	@private
		*/
		protected function getDebugMessage( phase:String, event:RslEvent ):String
		{
			var uri:String = "";
			if( event.uri != null )
			{
				uri = " [" + event.uri + "]";
			}	
			var msg:String = "[" + phase + " :: " + event.type + "]"
				+ uri
				+ " " + int( event.percent ) + "%"
				+ " (" + event.bytesLoaded + "/" + event.bytesTotal + ")";
				
			return msg;
		}
		
		/**
		* 	@private
		*/
		protected function debug( phase:String, event:RslEvent ):String
		{
			var msg:String = getDebugMessage( phase, event );
			trace( msg );
			return msg;
		}
	}
}