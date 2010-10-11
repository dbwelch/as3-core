package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import com.ffsys.swat.configuration.IConfigurationAware;
	
	import com.ffsys.utils.css.IStyleStrategy;
	
	/**
	*	Abstract super class for application views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class AbstractSwatView extends Sprite
		implements IApplicationView {
			
		static private var _utils:IViewUtils
			= new ViewUtils();
			
		static private var _strategy:IStyleStrategy;
		
		private var _enabled:Boolean = true;
		private var _styles:String;
		
		/**
		*	Creates an <code>AbstractSwatView</code> instance.
		*/
		public function AbstractSwatView()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get strategy():IStyleStrategy
		{
			return _strategy;
		}
		
		public function set strategy( strategy:IStyleStrategy ):void
		{
			_strategy = strategy;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get styles():String
		{
			return _styles;
		}
		
		public function set styles( styles:String ):void
		{
			_styles = styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get utils():IViewUtils
		{
			return _utils;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createChildren():void
		{
			//
		}
		
		/**
		* 	Adds a child display list instance to this instance.
		* 
		* 	@param child The child display object.
		*/
		override public function addChild( child:DisplayObject ):DisplayObject
		{
			if( child is IConfigurationAware )
			{
				IConfigurationAware( child ).configuration = utils.configuration;
			}
			
			super.addChild( child );
			
			if( child is IApplicationView )
			{
				IApplicationView( child ).createChildren();
			}
			
			return child;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set enabled( enabled:Boolean ):void
		{
			_enabled = enabled;
			
			this.mouseEnabled = enabled;
			this.mouseChildren = enabled;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeAllChildren():void
		{
			var child:DisplayObject = null;
			for( var i:int = 0;i < numChildren;i++ )
			{
				child = getChildAt( i );
				removeChild( child );
				i--;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function destroy():void
		{
			_styles = null;
		}
	}
}