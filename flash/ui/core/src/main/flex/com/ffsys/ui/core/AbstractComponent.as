package com.ffsys.ui.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;	
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	import com.ffsys.ui.layout.ILayout;
	
	import com.ffsys.ui.common.IMargin;
	import com.ffsys.ui.common.IPadding;
	import com.ffsys.ui.common.Margin;
	import com.ffsys.ui.common.Padding;
	
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.text.core.TextFieldFactory;	

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
		
		private var _margins:IMargin = new Margin();
		private var _paddings:IPadding = new Padding();
		private var _id:String;
		private var _preferredWidth:Number = 25;
		private var _preferredHeight:Number = 25;
		private var _extra:Object;
		private var _border:IComponentGraphic;
		private var _background:IComponentGraphic;
		
		/**
		* 	Creates an <code>AbstractComponent</code> instance.
		*/
		public function AbstractComponent()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get extra():Object
		{
			return _extra;
		}
		
		public function set extra( extra:Object ):void
		{
			_extra = extra;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get preferredWidth():Number
		{
			return _preferredWidth;
		}
		
		public function set preferredWidth( val:Number ):void
		{
			_preferredWidth = val;
		}
		
		/**
		*	@inheritDoc	
		*/
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
		*	@inheritDoc	
		*/
		public function get layoutWidth():Number
		{
			return this.width;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get layoutHeight():Number
		{
			return this.height;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get paddings():IPadding
		{
			return _paddings;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get margins():IMargin
		{
			return _margins;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function addChild(
			child:DisplayObject ):DisplayObject
		{
			var shouldAdd:Boolean = beforeChildAdded( child, numChildren );
			if( shouldAdd )
			{
				super.addChild( child );
				afterChildAdded( child, numChildren - 1 );
			}
			return child;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function addChildAt(
			child:DisplayObject, index:int ):DisplayObject
		{
			var shouldAdd:Boolean = beforeChildAdded( child, index );
			if( shouldAdd )
			{
				super.addChildAt( child, index );
				afterChildAdded( child, index );
			}			
			
			return child;
		}
		
		/**
		*	Invoked before a child is added.
		*	
		*	@param child The child to be added.
		*	@param index The index the child will be 
		*	added at.
		*	
		*	@return Whether the child should be added.
		*/
		protected function beforeChildAdded(
			child:DisplayObject, index:int ):Boolean
		{
			return true;
		}
		
		/**
		*	Invoked after a child has been added.
		*	
		*	@param child The child that was added.	
		*	@param index The index of the child.
		*/
		protected function afterChildAdded(
			child:DisplayObject,
			index:int ):void
		{
			//graphics with no visible area should be drawn
			//at the preferred dimensions
			if( child is IComponentGraphic
				&& ( child.width == 0 && child.height == 0 ) )
			{
				var graphic:IComponentGraphic = IComponentGraphic( child );
				
				var width:Number = isNaN( graphic.preferredWidth )
					? this.preferredWidth : graphic.preferredWidth;
					
				var height:Number = isNaN( graphic.preferredHeight )
					? this.preferredHeight : graphic.preferredHeight;
					
				graphic.draw( width, height );
			}
			
			//ensure the background is always the first child
			if( this.background
				&& this.contains( DisplayObject( this.background ) )
				&& numChildren > 1 )
			{
				this.setChildIndex( DisplayObject( this.background ), 0 );
			}
			
			//ensure the border is always the last child
			if( this.border
				&& this.contains( DisplayObject( this.border ) )
				&& numChildren > 1 )
			{
				this.setChildIndex( DisplayObject( this.border ), this.numChildren - 1 );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function removeChild(
			child:DisplayObject ):DisplayObject
		{
			var index:int = this.getChildIndex( child );
			var shouldRemove:Boolean = beforeChildRemoved( child, index );
			
			if( shouldRemove )
			{
				super.removeChild( child );
				afterChildRemoved( child, index );
			}
			return child;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function removeChildAt(
			index:int ):DisplayObject
		{
			var child:DisplayObject = getChildAt( index );
			var shouldRemove:Boolean = beforeChildRemoved( child, index );
			if( shouldRemove )
			{			
				super.removeChildAt( index );
				afterChildRemoved( child, index );
			}
			return child;
		}
		
		/**
		*	Invoked before a child is removed.
		*	
		*	@param child The child to be removed.
		*	@param index The index of the child.
		*	
		*	@return Whether the child should be added.
		*/
		protected function beforeChildRemoved(
			child:DisplayObject, index:int ):Boolean
		{
			return true;
		}
		
		/**
		*	Invoked after a child has been added.
		*	
		*	@param child The child that was added.	
		*/
		protected function afterChildRemoved(
			child:DisplayObject,
			index:int ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get textFieldFactory():ITextFieldFactory
		{
			return _textFieldFactory;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get border():IComponentGraphic
		{
			return _border;
		}
		
		public function set border( border:IComponentGraphic ):void
		{
			if( this.border && contains( this.border as DisplayObject ) )
			{
				removeChild( DisplayObject( this.border ) );
			}
			
			_border = border;
			
			if( this.border )
			{
				addChild( DisplayObject( this.border ) );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get background():IComponentGraphic
		{
			return _background;
		}

		public function set background( background:IComponentGraphic ):void
		{
			if( this.background && contains( this.background as DisplayObject ) )
			{
				removeChild( DisplayObject( this.background ) );
			}

			_background = background;

			if( this.background )
			{
				addChild( DisplayObject( this.background ) );
			}
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
		public function getPaddingRectangle():Rectangle
		{
			return new Rectangle(
				paddings.left,
				paddings.top,
				preferredWidth - ( paddings.left + paddings.right ),
				preferredHeight - ( paddings.top + paddings.bottom ) );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getRectangle():Rectangle
		{
			return new Rectangle( 0, 0, this.preferredWidth, this.preferredHeight );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getMarginRectangle():Rectangle
		{
			return new Rectangle(
				-margins.left,
				-margins.top,
				preferredWidth + margins.left + margins.right,
				preferredHeight + margins.top + margins.bottom );
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