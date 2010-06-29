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
		* 	The default behaviour is to invoke <code>createChildren</code>.
		*/
		protected function added( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, added );
			addEventListener( Event.REMOVED_FROM_STAGE, removed );
			
			//trace("UIComponent::added()", this, root, utils, utils.layer );
			
			//initialize the root component layer
			if( root
				&& utils
				&& utils.layer
				&& !utils.layer.initialized
				&& !( this is IComponentRootLayer ) )
			{
				utils.layer.initialize( root );
			}
			
			//ensure the component view utils have the root and stage references
			if( root && stage && utils )
			{
				var concrete:ComponentViewUtils = ComponentViewUtils( utils );
				if( !concrete._root )
				{
					concrete._root = root;
				}
				
				if( !concrete._stage )
				{
					concrete._stage = stage;
				}
			}
			
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
		
		/**
		*	Provides static access to the utilities exposed
		*	to all components.
		*/
		public static function get utilities():IComponentViewUtils
		{
			return _utils;
		}
	}
}