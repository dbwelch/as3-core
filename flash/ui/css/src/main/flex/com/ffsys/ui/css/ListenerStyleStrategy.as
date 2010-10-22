package com.ffsys.ui.css {
	
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
	public class ListenerStyleStrategy extends AbstractStyleStrategy {
		
		/**
		*	The stage used to hook into added events.	
		*/
		public var stage:Stage;
		
		/**
		*	Creates a <code>ListenerStyleStrategy</code> instance.
		*/
		public function ListenerStyleStrategy()
		{
			super();
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
			
			this.stage = stage;
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
				applyStyles( IStyleAware( target ) );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function destroy():void
		{
			super.destroy();
			if( stage )
			{
				stage.removeEventListener( Event.ADDED, added );
			}
		}
	}
}