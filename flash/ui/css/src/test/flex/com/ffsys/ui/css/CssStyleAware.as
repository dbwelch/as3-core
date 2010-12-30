package com.ffsys.ui.css
{
	import flash.display.Sprite;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.common.IStyleAware;	
	
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
		implements 	IStyleAware,
					IStringIdentifier
	{
		private var _id:String;
		private var _styles:String;
		private var _styleManager:IStyleManager;
		private var _classLevelColor:Number;
		private var _identifierLevelColor:Number;
		private var _customColor:Number;
		
		/**
		* 	Creates a <code>CssStyleAware</code> instance.
		* 
		* 	@param manager The style manager for the application.
		*/
		public function CssStyleAware( manager:IStyleManager = null )
		{
			super();
			_styleManager = manager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
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
		* 	A method declaration for testing references to instance methods.
		*/
		public function doSomethingSpecial():void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function applyStyles():Array
		{
			if( _styleManager )
			{
				return _styleManager.style( this );
			}
			return null;
		}
		
		/**
		* 	Represents a syle property declared at the class level.
		*/		
		public function get classLevelColor():Number
		{
			return _classLevelColor;
		}
		
		public function set classLevelColor( value:Number ):void
		{
			_classLevelColor = value;
		}
		
		/**
		* 	Represents a syle property declared at the identifier level.
		*/		
		public function get identifierLevelColor():Number
		{
			return _identifierLevelColor;
		}
		
		public function set identifierLevelColor( value:Number ):void
		{
			_identifierLevelColor = value;
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