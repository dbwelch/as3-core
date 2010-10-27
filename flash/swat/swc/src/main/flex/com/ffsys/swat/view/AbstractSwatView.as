package com.ffsys.swat.view  {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	
	import com.ffsys.swat.configuration.IConfigurationAware;
	
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
		public function applyStyles():void
		{
			//do nothing at the moment
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
		public function get flashvars():IFlashVariables
		{
			return utils.flashvars;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return utils.getMessage.apply(
				utils, replacements );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return utils.getError.apply(
				utils, replacements );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			return utils.getXmlDocument( id );			
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getStyleSheet( id:String ):ICssStyleSheet
		{
			return utils.getStyleSheet( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			return utils.styleManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			return utils.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			utils.setStyle( styleName, style );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			return utils.getImage( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			return utils.getSound( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			return utils.getFilter( id );
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