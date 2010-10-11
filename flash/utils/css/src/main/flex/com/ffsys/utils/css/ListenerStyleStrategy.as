package com.ffsys.utils.css {
	
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	*	Listens for stage events and applies styles
	*	as objects are added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public class ListenerStyleStrategy extends Object
		implements IStyleStrategy {
			
		private var _styleSheet:CssStyleCollection;
		
		/**
		*	Creates a <code>ListenerStyleStrategy</code> instance.
		*/
		public function ListenerStyleStrategy()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get styleSheet():CssStyleCollection
		{
			return _styleSheet;
		}
		
		public function set styleSheet( styleSheet:CssStyleCollection ):void
		{
			_styleSheet = styleSheet;
		}
		
		/**
		*	Initializes this strategy with a stage reference.
		*	
		*	@param stage A valid stage reference.
		*/
		public function initialize( stage:Stage ):void
		{
			if( !stage )
			{
				throw new Error(
					"Cannot initialize css listener strategy with a null stage reference." );
			}
			
			stage.removeEventListener( Event.ADDED, added );
			stage.addEventListener( Event.ADDED, added );
		}
		
		/**
		*	Applies styles as display objects are added.
		*	
		*	@param event The event that triggered this listener.	
		*/
		private function added( event:Event ):void
		{
			var target:Object = event.target;

			if( target is IStyleAware )
			{
				if( styleSheet )
				{
					styleSheet.apply( 
						IStyleAware( target ).styles, target );
				}
			}
		}
	}
}