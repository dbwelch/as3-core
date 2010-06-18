package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.text.ITextFieldFactory;
	import com.ffsys.ui.text.TextFieldFactory;
	
	import com.ffsys.utils.collections.strings.StringCollection;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.Settings;
	
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
		
		private var _enabled:Boolean = true;
		
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
	}
}