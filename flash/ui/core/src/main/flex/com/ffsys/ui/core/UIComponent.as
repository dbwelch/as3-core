package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	
	import com.ffsys.ui.css.*;
	
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
		*	The style manager responsible for managing loaded
		*	style sheets and for applying styles to components.
		*/
		static public var styleManager:IStyleManager = new StyleManager();
		
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
		override public function set styles( value:String ):void
		{
			trace("UIComponent::styles(), ", value, this.styles );
			
			//if( value != this.styles )
			//{
				
				super.styles = value;
				
				if( this.styles && this.styles.length > 0 && styleManager )
				{
					/*
					trace("UIComponent::has styles(), ", styles, css, css.length );
					var sheet:CssStyleCollection = null;
					for each( sheet in css )
					{
						trace("UIComponent::styles(), APPLYING STYLES: ", styles, sheet );
						sheet.apply( styles, this );
					}
					*/
					
					trace("UIComponent::styles(), APPLYING STYLES: ", styles, this );
					
					styleManager.apply( this, styles );
				}
				
			//}
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