package com.ffsys.ui.components.core
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
		protected function createChildren():void
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
			trace("UIComponent::added(), ", this, this.parent );
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
			trace("UIComponent::removed(), ", this, this.parent );
		}
	}
}