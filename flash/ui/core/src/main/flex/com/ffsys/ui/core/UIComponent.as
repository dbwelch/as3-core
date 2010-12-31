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
		
		private var _state:State;
		
		/**
		* 	Creates a <code>UIComponent</code> instance.
		*/
		public function UIComponent()
		{
			super();
		}
		
		/**
		* 	Ensures the state changes when the enabled
		* 	property is set.
		*/
		override public function set enabled( enabled:Boolean ):void
		{
			super.enabled = enabled;
			updateState( this.enabled ? State.MAIN : State.DISABLED );
		}
		
		/**
		* 	The current state of this component.
		*/
		public function get state():State
		{
			return _state;
		}				
		
		public function set state( value:State ):void
		{
			//force to the main state
			if( value == null )
			{
				value = State.MAIN;
			}

			_state = value;
		}
		
		/**
		* 	Sets the state of this component and updates
		* 	the styles applied to this component.
		*/
		protected function updateState(
			state:State ):void
		{
			this.state = state;
			applyStyles();
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
				var stylesheet:ICssStyleSheet = styleManager.stylesheet;
				var styleNames:Array = stylesheet.getStyleNameList( this );
				
				//apply all normal styles
				var output:Array = stylesheet.style( this );
				
				//find one matching a non-main state
				//if a state has been specified
				if( styleNames != null
					&& this.state != null
					&& this.state.primary != State.MAIN_ID )
				{
					trace("UIComponent::applyStyles()", styleNames, this, this.id );
					
					var stateStyles:Array = new Array();
					var stateStyle:Object = null;
					var name:String = null;
  					for( var i:int = 0;i < styleNames.length;i++ )
					{

						name = styleNames[ i ]
							+ State.DELIMITER
							+ this.state.toStateString();
							
						trace("UIComponent::applyStyles() state style search name:", name );
						
						stateStyle = stylesheet.getStyle( name );
						if( stateStyle != null )
						{
							stateStyles.push( stateStyle );
						}
					}

					if( stateStyles.length > 0 )
					{
						output = output.concat( stateStyles );
						stylesheet.applyStyles( this, stateStyles );
					}
				}
				return output;				
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