package com.ffsys.ui.css
{
	import flash.display.Sprite;
	
	/**
	* 	Example of implementing the style aware contract.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.10.2010
	*/
	public class CssStyleAware extends Sprite
		implements IStyleAware
	{
		private var _styles:String;
		private var _styleManager:IStyleManager;
		private var _customColor:Number;
		
		/**
		* 	Creates a <code>CssStyleAware</code> instance.
		* 
		* 	@param manager The style manager for the application.
		*/
		public function CssStyleAware( manager:IStyleManager )
		{
			super();
			_styleManager = manager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styles():String
		{
			return _styles;
		}
		
		public function set styles( value:String ):void
		{
			_styles = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function applyStyles():void
		{
			if( _styleManager )
			{
				_styleManager.style( this );
			}
		}
		
		/**
		* 	Represents a custom color style that will be applied
		* 	to this implementation.
		*/
		public function get customColor():Number
		{
			return _customColor;
		}
		
		public function set customColor( value:Number ):void
		{
			_customColor  = value;
		}
	}
}