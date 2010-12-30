package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.graphics.ComponentGraphic;
	
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
		*	@private
		*/
		static private var _styleManager:IStyleManager = null;
		
		private var _state:String;
		
		/**
		* 	Creates a <code>UIComponent</code> instance.
		*/
		public function UIComponent()
		{
			super();
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state( value:String ):void
		{
			//force to the main state
			if( value == null )
			{
				value = State.MAIN;
			}
			
			_state = value;
			
			if( styleManager != null )
			{
				var stylesheet:ICssStyleSheet = styleManager.stylesheet;
				var styleNames:Array = stylesheet.getStyleNameList( this );
				var allNames:Array = stylesheet.styleNames;
				
				//apply all normal styles
				stylesheet.style( this );
				
				//find one matching a non-main state
				if( this.state != State.MAIN )
				{
					var stateStyle:Object = null;
  					for( var i:int = 0;i < styleNames.length;i++ )
					{
						stateStyle = stylesheet.getStyle( styleNames[ i ] + ":" + this.state );
						if( stateStyle != null )
						{
							break;
						}
					}
				
					//trace("UIComponent::set state()", "SEARCHING FOR STATE IN STYLE MANAGER this/all: ", styleNames, allNames, stateStyle );
					
					if( stateStyle != null )
					{
						stylesheet.applyStyle( this, stateStyle );
					}
				}
			}
		}
		
		/**
		* 	The style manager for the components.
		*/
		public static function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public static function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
			ComponentGraphic.styleManager = value;
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
		override public function applyStyles():Array
		{
			if( styleManager )
			{
				return styleManager.style( this );
			}
			return null;
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