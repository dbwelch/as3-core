package com.ffsys.ui.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	import com.ffsys.ui.common.IMargin;
	import com.ffsys.ui.common.IPadding;
	import com.ffsys.ui.common.Margin;
	import com.ffsys.ui.common.Padding;
	
	import com.ffsys.ui.data.IDataBinding;
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
		/**
		*	@private	
		*/
		static protected var _utils:IComponentViewUtils;
		
		static private var _textFieldFactory:ITextFieldFactory
			= new TextFieldFactory();
			
		protected var _preferredWidth:Number = NaN;
		protected var _preferredHeight:Number = NaN;
		
		protected var _minimumWidth:Number = NaN;
		protected var _minimumHeight:Number = NaN;
		
		protected var _maximumWidth:Number = NaN;
		protected var _maximumHeight:Number = NaN;
		
		private var _margins:IMargin = new Margin();
		private var _paddings:IPadding = new Padding();
		private var _id:String;
		private var _extra:Object;
		private var _border:IComponentGraphic;
		private var _background:IComponentGraphic;
		private var _styles:String;
		
		private var _dataBinding:IDataBinding;
		
		/**
		* 	Creates an <code>AbstractComponent</code> instance.
		*/
		public function AbstractComponent()
		{
			super();
			
			if( !_utils && !( this is IComponentRootLayer ) )
			{
				_utils = new ComponentViewUtils();
			}
			
			created();
			
			if( utils && utils.layer && !utils.layer.initialized )
			{
				addEventListener( Event.ADDED_TO_STAGE, __initialize );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get dataBinding():IDataBinding
		{
			return _dataBinding;
		}
		
		public function set dataBinding( dataBinding:IDataBinding ):void
		{
			_dataBinding = dataBinding;
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
			//
		}
		
		/**
		*	Invoked when the component is instantiated.
		*	
		*	This is a useful place to set default properties
		*	for the component such as margins or paddings.	
		*/
		protected function created():void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get utils():IComponentViewUtils
		{
			return _utils;
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
		
		public function set preferredWidth( value:Number ):void
		{
			_preferredWidth = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get preferredHeight():Number
		{
			return _preferredHeight;
		}
		
		public function set preferredHeight( value:Number ):void
		{
			_preferredHeight = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get minimumWidth():Number
		{
			return _minimumWidth;
		}

		public function set minimumWidth( value:Number ):void
		{
			_minimumWidth = value;
		}

		/**
		*	@inheritDoc	
		*/
		public function get minimumHeight():Number
		{
			return _minimumHeight;
		}

		public function set minimumHeight( value:Number ):void
		{
			_minimumHeight = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get maximumWidth():Number
		{
			return _maximumWidth;
		}

		public function set maximumWidth( value:Number ):void
		{
			_maximumWidth = value;
		}

		/**
		*	@inheritDoc	
		*/
		public function get maximumHeight():Number
		{
			return _maximumHeight;
		}

		public function set maximumHeight( value:Number ):void
		{
			_maximumHeight = value;
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
			if( !isNaN( preferredWidth ) )
			{
				return preferredWidth;
			}
			
			return this.width;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get layoutHeight():Number
		{
			if( !isNaN( preferredHeight ) )
			{
				return preferredHeight;
			}
			
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
		* 	Invoked when this instance is added to the
		*	display list of a parent component.
		* 
		* 	By default this method does nothing.
		*	
		*	Concrete component implementations should
		*	override this method and create child
		*	components when this method is invoked.
		*/
		protected function createChildren():void
		{
			//
		}
		
		/**
		*	Invoked automatically after child components have been
		*	created and positioned during the layout phase.
		*/
		protected function childrenCreated():void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function setSize(
			width:Number, height:Number ):void
		{
			if( isNaN( width ) || width <= 0 )
			{
				throw new Error( "The component width parameter must be valid." );
			}
			
			if( isNaN( height ) || height <= 0 )
			{
				throw new Error( "The component height parameter must be valid." );
			}
			
			preferredWidth = width;
			preferredHeight = height;
			
			if( background )
			{
				background.setSize( width, height );
			}
			
			if( border )
			{
				border.setSize( width, height );
			}	
			
			layoutChildren( width, height );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function redraw():void
		{
			setSize( preferredWidth, preferredHeight );
		}
		
		/**
		*	Invoked after the children have been created
		*	to perform positioning of the child components
		*	and when this component is resized.
		*	
		*	When invoked the width and height passed as
		*	parameters will equal the preferred width and height
		*	for this component.
		*	
		*	@param width The target width for this component
		*	that should constrain the child layout.
		*	
		*	@param height The target height for this component
		*	that should constrain the child layout.
		*/
		protected function layoutChildren(
			width:Number, height:Number ):void
		{
			//
		}
		
		/**
		* 	Invoked when this instance is removed from the
		*	display list of a parent component.
		* 
		* 	By default this method removes all child display objects
		*	and calls destroy on this instance.
		*	
		*	Concrete component implementations can change
		*	the default behaviour by overriding this method.
		*/
		protected function removeChildren():void
		{
			removeAllChildren();
			destroy();
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
			
			var component:UIComponent = child as UIComponent;
			if( component )
			{
				//invoke the internal added method on the child
				//component to get it to create it's children
				component.added();
			}
			
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
			var component:UIComponent = child as UIComponent;
			if( component )
			{
				//invoke the internal removed method on the child
				//component to get it to remove it's children
				component.removed();
			}
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
				addChildAt( DisplayObject( this.background ), 0 );
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
			
			return getRuntimeInstance( clz );		
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRuntimeInstance( clazz:Class ):Object
		{
			var instance:Object = null;
			
			try
			{
				instance = new clazz();
			}catch( e:Error )
			{
				throw new Error(
					"Could not instantiate runtime instance with class '"
					+ clazz + "'." );
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
		
		
		public function getVisibleBounds(
			target:DisplayObject = null ):Rectangle 
		{ 
			if( target == null )
			{
				target = this;
			}
			
			var currentBounds:Rectangle = target.getBounds( target );
			
			var matrix:Matrix = new Matrix();
			matrix.translate( Math.abs( currentBounds.left ), Math.abs( currentBounds.top ) );
		
			var radians:Number = target.rotation * Math.PI / 180;
			matrix.rotate( radians );
			matrix.scale( Math.abs( target.scaleX ), Math.abs( target.scaleY ) );
		
			var bitmapData:BitmapData = new BitmapData(
				target.width, target.height, true, 0x00000000 );
			bitmapData.draw( target, matrix );
			var bounds:Rectangle = bitmapData.getColorBoundsRect( 0xFF000000, 0, false );
			bitmapData.dispose();
			
			var output:Rectangle = new Rectangle(
				currentBounds.left,
				currentBounds.top,
				bounds.width,
				bounds.height );
		
			return output;
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
		*	Invoked when a component is added to the display list
		*	of a parent component.
		*	
		*	By default this implemention creates the children
		*	for the component.
		*/
		internal function added():void
		{
			createChildren();
			layoutChildren( preferredWidth, preferredHeight );
			childrenCreated();
		}
		
		/**
		*	Invoked when a component is removed from the display list
		*	of a parent component.
		*	
		*	By default this implemention removes child display objects.
		*/
		internal function removed():void
		{
			removeChildren();
		}
		
		/**
		*	@private
		*	
		* 	Performs intialization of the component root layer
		*	the first time a component is added to the stage.
		*/
		private function __initialize( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, __initialize );

			//initialize the root component layer
			if( root
				&& utils
				&& utils.layer
				&& !utils.layer.initialized
				&& !( this is IComponentRootLayer ) )
			{
				utils.layer.initialize( root );
			}
		
			//ensure the component view utils have the root and stage references
			if( root && stage && utils )
			{
				var concrete:ComponentViewUtils = ComponentViewUtils( utils );
				if( !concrete._root )
				{
					concrete._root = root;
				}
			
				if( !concrete._stage )
				{
					concrete._stage = stage;
					
					if( !concrete._renderer && stage )
					{
						concrete._renderer = new ComponentRenderer( stage );
					}
				}
			}
		}		
	}
}