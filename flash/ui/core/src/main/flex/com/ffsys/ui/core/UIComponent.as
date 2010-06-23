package com.ffsys.ui.core
{
	import flash.events.Event;
	
	/**
	*	The default component implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class UIComponent extends AbstractComponent
	{		
		/**
		* 	Creates a <code>UIComponent</code> instance.
		*/
		public function UIComponent()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, added );
		}
		
		/**
		* 	Invoked when this instance is added to the display list.
		* 
		* 	This method does nothing by default.
		*/
		override protected function createChildren():void
		{
			//
		}
		
		/**
		* 	Invoked when this instance is added to the display list.
		* 
		* 	The default behaviour is to invoke <code>createChildren</code>.
		*/
		protected function added( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, added );
			addEventListener( Event.REMOVED_FROM_STAGE, removed );
			createChildren();
		}
		
		/**
		* 	Invoked when this instance is removed from the display list.
		* 
		* 	The default behaviour is to invoke <code>destroy</code>.
		*/
		protected function removed( event:Event ):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removed );
			destroy();
		}
		
		/**
		*	Gets a string representation of this component.	
		*/
		override public function toString():String
		{
			/*
			if( this.name )
			{
				return this.name;
			}
			*/
			
			return super.toString();
		}
	}
}