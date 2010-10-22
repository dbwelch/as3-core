package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	
	import com.ffsys.ui.css.CssStyleCollection;
	
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
		*	A collection of style sheets to apply
		*	to child objects before they are added.	
		*/
		public static var css:Vector.<CssStyleCollection>
			= new Vector.<CssStyleCollection>();
		
		/**
		* 	Creates a <code>UIComponent</code> instance.
		*/
		public function UIComponent()
		{
			super();
		}
		
		/**
		*	Invoked when this component receives focus.	
		*	
		*	@param event The focus event.
		*/
		internal function focusIn( event:FocusEvent ):void
		{
			//trace("UIComponent::focusIn(), ", this );
		}
		
		/**
		*	Invoked when this component loses focus.
		*	
		*	@param event The focus event.
		*/
		internal function focusOut( event:FocusEvent ):void
		{
			//trace("UIComponent::focusOut(), ", this );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function beforeChildAdded(
			child:DisplayObject, index:int ):Boolean
		{
			trace("UIComponent::beforeChildAdded(), ", styles );
			if( styles && styles.length > 0 )
			{
				var sheet:CssStyleCollection = null;
				for each( sheet in css )
				{
					trace("UIComponent::beforeChildAdded(), APPLYING STYLES: ", styles );
					sheet.apply( styles, child );
				}
			}
			
			return true;
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