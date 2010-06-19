package com.ffsys.ui.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;	
	
	import com.ffsys.ui.text.ITextFieldFactory;
	import com.ffsys.ui.text.TextFieldFactory;
	import com.ffsys.ui.layout.ILayout;

	/**
	*	Abstract super class for all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractComponent extends Sprite
		implements IComponent
	{	
		static private var _textFieldFactory:ITextFieldFactory
			= new TextFieldFactory();
			
		private var _layout:ILayout;
		private var _id:String;
		private var _preferredWidth:Number = 25;
		private var _preferredHeight:Number = 25;
		
		/**
		* 	Creates an <code>AbstractComponent</code> instance.
		*/
		public function AbstractComponent()
		{
			super();
		}
		
		public function get preferredWidth():Number
		{
			return _preferredWidth;
		}
		
		public function set preferredWidth( val:Number ):void
		{
			_preferredWidth = val;
		}
		
		public function get preferredHeight():Number
		{
			return _preferredHeight;
		}
		
		public function set preferredHeight( val:Number ):void
		{
			_preferredHeight = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get id():String
		{
			return _id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get layout():ILayout
		{
			return _layout;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set layout( layout:ILayout ):void
		{
			_layout = layout;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function addChild(
			child:DisplayObject ):DisplayObject
		{
			super.addChild( child );
			
			//trace("AbstractComponent::addChild(), ", child );
			
			if( layout && child )
			{
				layout.added( child );
			}
			
			return child;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function removeChild(
			child:DisplayObject ):DisplayObject
		{
			
			//trace("AbstractComponent::removeChild(), ", child );
			
			if( layout && child )
			{
				layout.removed( child );
			}
			
			super.removeChild( child );
			
			return child;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get textFieldFactory():ITextFieldFactory
		{
			return _textFieldFactory;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRuntimeAsset( classPath:String ):Object
		{
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate a class for a runtime asset with class path '"
					+ classPath + "'." );
			}
			
			var instance:Object = null;
			
			try
			{
				instance = new clz();
			}catch( e:Error )
			{
				throw new Error(
					"Could not instantiate runtime asset with class path '"
					+ classPath + "'." );
			}
			
			return instance;		
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRuntimeDisplayObject( classPath:String ):DisplayObject
		{
			var instance:Object = getRuntimeAsset( classPath );
			
			if( !( instance is DisplayObject ) )
			{
				throw new Error(
					"The runtime asset is not a display object." );
			}
			
			return DisplayObject( instance );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return mouseEnabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set enabled( enabled:Boolean ):void
		{
			mouseEnabled = enabled;
			mouseChildren = enabled;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function draw(
			width:Number = NaN, height:Number = NaN ):void
		{
			//
		}		
		
		/**
		* 	Performs clean up of this instance.
		* 
		* 	The implementation of this method should clean any
		* 	event listeners and null any references to complex objects.
		*/
		public function destroy():void
		{
			//
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBitmap( matrix:Matrix = null ):Bitmap
		{
			if( matrix == null )
			{
				matrix = new Matrix();
			}
			
			var bitmapData:BitmapData = new BitmapData(
				this.width, this.height, true, 0x00000000 );
			bitmapData.draw( this, matrix );
			return new Bitmap( bitmapData );
		}
	}
}