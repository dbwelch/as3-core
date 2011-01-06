package com.ffsys.ui.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;	
	
	import com.ffsys.ui.graphics.*;

	import com.ffsys.ui.common.Border;
	import com.ffsys.ui.common.IBorder;	
	import com.ffsys.ui.common.IMargin;
	import com.ffsys.ui.common.IPadding;
	import com.ffsys.ui.common.Margin;
	import com.ffsys.ui.common.Padding;
	
	import com.ffsys.ui.css.*;
	
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.text.core.TextFieldFactory;
	
	import com.ffsys.utils.properties.IMessagesAware;
	import com.ffsys.utils.properties.IProperties;	
	
	import com.ffsys.utils.string.PropertyNameConverter;

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
		implements IMessagesAware
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
		
		private var _margins:IMargin;
		private var _paddings:IPadding;
		private var _id:String;
		private var _extra:Object;
		private var _border:IBorder;
		private var _background:IComponentGraphic;
		private var _styles:String;
		private var _customData:Object;
		
		private var _borderLayer:DisplayObjectContainer;
		private var _borderGraphic:IComponentGraphic;
		
		private var _identifier:String;
		private var _messages:IProperties;	
		
		private var _parents:Vector.<DisplayObjectContainer>;
		private var _class:Class;		
		
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
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStage );
		}
		
		/**
		* 	A collection of messages this text component
		* 	should select text from based on the <code>identifier</code>.
		*/
		public function get messages():IProperties
		{
			return _messages;
		}
		
		public function set messages( value:IProperties ):void
		{
			_messages = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get identifier():String
		{
			return _identifier;
		}
		
		public function set identifier( value:String ):void
		{
			_identifier = value;
		}				
		
		/**
		* 	@inheritDoc
		*/
		public function get customData():Object
		{
			return _customData;
		}
		
		public function set customData( value:Object ):void
		{
			_customData = value;
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
		public function applyStyles():Array
		{
			return null;
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
		* 	@inheritDoc
		*/
		public function prefinalize():void
		{
			//
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
			
			//set a name from the id
			if( _id != null )
			{
				var converter:PropertyNameConverter = new PropertyNameConverter();	
				this.name = converter.convert( _id );
			}
		}
		
		/**
		*	Ensures that all components have a valid name.
		*/
		override public function get name():String
		{	
			var name:String = super.name;
			var re:RegExp = /^instance([0-9]+)$/;
			
			if( re.test( name ) )
			{
				var className:String = getClassPath().replace( /^[^:]+::(.*)$/, "$1" );
				className = className.toLowerCase();
			
				//keep the numeric id
				name = name.replace( re, "$1" );
			
				if( this.parent != null )
				{
					//use an id of our index of we are on the display list
					name = new String( this.parent.getChildIndex( this ) );
				}
			
				name = className + name;
			}
			return name;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getAncestorNames( root:Boolean = false ):Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			var parents:Vector.<DisplayObjectContainer> = this.parents;
			var i:int = 1;
			if( !root )
			{
				i = 2;
			}
			var p:DisplayObjectContainer = null;
			for( ;i < parents.length;i++ )
			{
				p = parents[ i ];
				output.push( p.name );
			}
			return output;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClassPath( target:Object = null ):String
		{
			if( target == null )
			{
				target = this;
			}
			return getQualifiedClassName( target );
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClass( target:Object = null ):Class
		{
			if( target is Class )
			{
				return target as Class;
			}
			
			if( target == null )
			{
				target = this;
			}
			
			if( _class == null )
			{
				_class = getDefinitionByName(
					getClassPath( target ) ) as Class;
			}
			return _class;
		}		
		
		/**
		*	@inheritDoc 
		*/
		public function toNameString(
			delimiter:String = ".", root:Boolean = false ):String
		{
			var names:Vector.<String> = getAncestorNames( root );
			names.push( this.name );
			return names.join( delimiter );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get actualWidth():Number
		{
			return layoutWidth + paddings.width;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get actualHeight():Number
		{
			return layoutHeight + paddings.height;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get innerWidth():Number
		{
			if( !isNaN( preferredWidth ) )
			{
				return preferredWidth - paddings.width - border.width;
			}
			return this.width;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get innerHeight():Number
		{
			if( !isNaN( preferredHeight ) )
			{
				return preferredHeight - paddings.height - border.height;
			}
			return this.height;
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
			if( _paddings == null )
			{
				_paddings = new Padding();
			}
			return _paddings;
		}
		
		public function set paddings( value:IPadding ):void
		{
			_paddings = value;
		}
		
		/**
		* 	Adds the padding, margin and border width values
		* 	to a number.
		* 
		* 	@param value The numeric value.
		* 	
		* 	@return The value with padding, margin and border
		* 	information added.
		*/
		protected function addLayoutWidthDimensions( value:Number ):Number
		{
			return value + ( paddings.width + margins.width + border.width );
		}
		
		/**
		* 	Adds the padding, margin and border height values
		* 	to a number.
		* 
		* 	@param value The numeric value.
		* 	
		* 	@return The value with padding, margin and border
		* 	information added.
		*/
		protected function addLayoutHeightDimensions( value:Number ):Number
		{
			return value + ( paddings.height + margins.height + border.height );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get margins():IMargin
		{
			if( _margins == null )
			{
				_margins = new Margin();
			}
			return _margins;
		}
		
		public function set margins( value:IMargin ):void
		{
			_margins = value;
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
			var component:UIComponent = child as UIComponent;
			if( component )
			{
				//invoke the internal before added method on the child
				//component to get it to apply styles
				component.beforeAdded();
			}
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
				
				//trace("AbstractComponent::afterChildAdded()", graphic.preferredWidth, graphic.preferredHeight );
				
				//update styles before deciding whether
				//to defer dimensions to this component
				graphic.applyStyles();
				
				//trace("AbstractComponent::afterChildAdded() AFTER APPLYING STYLES: ", graphic.preferredWidth, graphic.preferredHeight );				
				
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
			var borderTarget:DisplayObject = _borderLayer != null
				? _borderLayer : _borderGraphic as DisplayObject;
			
			if( borderTarget != null
				&& contains( borderTarget )
				&& numChildren > 1 )
			{
				setChildIndex( borderTarget, this.numChildren - 1 );
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
		public function get border():IBorder
		{
			if( _border == null )
			{
				_border = new Border();
			}
			return _border;
		}
		
		public function set border( border:IBorder ):void
		{
			_border = border;
		}
		
		/**
		* 	Creates the layer used to store border graphics.
		*/
		protected function createBorderLayer():void
		{
			if( _borderLayer && contains( _borderLayer ) )
			{
				removeChild( _borderLayer );
			}
			
			this.borderLayer = new Sprite();
		}
		
		/**
		* 	A custom graphic to use as the border
		* 	for this component.
		*/
		public function get borderGraphic():IComponentGraphic
		{
			return _borderGraphic;
		}
		
		public function set borderGraphic( value:IComponentGraphic ):void
		{
			if( _borderGraphic != null
			 	&& contains( DisplayObject( _borderGraphic ) ) )
			{
				removeChild( DisplayObject( _borderGraphic ) );
			}
			
			_borderGraphic = value;
			
			if( _borderGraphic != null )
			{
				addChild( DisplayObject( _borderGraphic ) );
			}
		}
		
		/**
		* 	The border layer used to render border graphics
		* 	declared as css borders.
		* 
		* 	@return The border layer.
		*/
		public function get borderLayer():DisplayObjectContainer
		{
			return _borderLayer;
		}
		
		public function set borderLayer( value:DisplayObjectContainer ):void
		{
			if( _borderLayer != null
			 	&& contains( _borderLayer ) )
			{
				removeChild( _borderLayer );
			}
			
			_borderLayer = value;
			
			if( _borderLayer != null )
			{
				addChild( _borderLayer );
			}
		}
		
		/**
		* 	Gets an instance of the border graphic class.
		* 
		* 	@return An instance of the border graphic class.
		*/
		protected function getBorderGraphic():IBorderGraphic
		{
			var graphic:Class = BorderGraphic;
			var b:IBorderGraphic = new graphic() as IBorderGraphic;
			
			if( b == null )
			{
				throw new Error(
					"Could not locate a valid border graphic implementation using border graphic class '"
				 	+ graphic + "'." );
			}

			return b;
		}
		
		/**
		* 	Updates the background graphics to match
		* 	the preferred dimensions.
		*/
		protected function applyBackground():void
		{
			if( this.background != null )
			{
				var rect:Rectangle = getBackgroundRect();
				this.background.x = rect.x;
				this.background.y = rect.y;
				
				this.background.preferredWidth = rect.width;
				this.background.preferredHeight = rect.height;
				this.background.draw( this.preferredWidth, this.preferredHeight );
			}
		}
		
		protected function getBackgroundRect():Rectangle
		{
			var w:Number = this.preferredWidth - border.width;
			var h:Number = this.preferredHeight - border.height;
			return new Rectangle( border.left, border.top, w, h );
		}
		
		/**
		* 	Creates border graphics and renders them in the
		* 	border layer.
		*/
		protected function applyBorders():void
		{
			//no border information nothing to do
			if( this.border == null
			 	|| !this.border.valid() ) 
			{
				if( _borderLayer != null
					&& contains( _borderLayer ) )
				{
					removeChild( _borderLayer );
					_borderLayer = null;
				}
				return;
			}
			
			if( _borderLayer == null )
			{
				createBorderLayer();
			}else
			{
				removeAllChildren( _borderLayer );
			}
	
			var r:Rectangle = getBorderDimensions();			
			
			//no custom graphic
			if( _borderGraphic == null )
			{
				var b:IBorderGraphic = getBorderGraphic();
				b.border = this.border;
				b.draw( r.width, r.height );
				_borderLayer.addChild( DisplayObject( b ) );
			}else{
				var c:IComponentGraphic = _borderGraphic;
				c.draw( r.width, r.height );
				if( !_borderLayer.contains( DisplayObject( c ) ) )
				{
					_borderLayer.addChild( DisplayObject( c ) );
				}
			}
		}
		
		/**
		* 	Gets the rectangle that defines the border for the
		* 	component.
		* 
		* 	@return The component border dimensions.
		*/
		protected function getBorderDimensions():Rectangle
		{
			return new Rectangle( 0, 0, layoutWidth, layoutHeight );
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
			if( this.background
				&& contains( this.background as DisplayObject ) )
			{
				removeChild( DisplayObject( this.background ) );
			}

			_background = background;

			if( this.background )
			{
				addChildAt( DisplayObject( this.background ), 0 );
				
				//ensure background dimensions are kept in sync
				//as style states change
				//applyBackground();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		//TODO: deprecate		
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
		//TODO: deprecate		
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
		//TODO: deprecate
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
		public function removeAllChildren(
			target:DisplayObjectContainer = null ):void
		{
			if( target == null )
			{
				target = this;
			}
			
			var child:DisplayObject = null;
			for( var i:int = 0;i < target.numChildren;i++ )
			{
				child = target.getChildAt( i );
				target.removeChild( child );
				i--;
			}
		}
		
		/**
		*	Invoked when a component is about to be added to the display list
		*	of a parent component.
		*	
		*	By default this implemention applies style information.
		*/
		internal function beforeAdded():void
		{
			//apply style information by default
			//applyStyles();
			//updateState( State.MAIN );
		}
		
		/**
		* 	Attempts to find an ancestor display object
		* 	of the specified type.
		* 
		* 	By default this implementation searches
		* 	from the direct parent to the stage.
		* 
		* 	When the <code>reverse</code> parameter is false
		* 	the search begins from the stage not from the direct
		* 	parent of this component.
		* 
		* 	@param type The type of ancestor to search for.
		* 	@param reverse Whether to reverse the parent hierarchy
		* 	so the lookup is performed backwards from this component.
		* 
		* 	@return The ancestor if it was found otherwise <code>null</code>.
		*/
		public function getAncestorByType(
			type:Class, reverse:Boolean = true ):DisplayObjectContainer
		{
			var ancestor:DisplayObjectContainer = null;
			//get a copy of the parent hierarchy
			var targets:Vector.<DisplayObjectContainer> = this.parents.slice();
			
			if( reverse )
			{
				targets.reverse();
			}
			
			//trace("AbstractComponent::getAncestorByType()", targets );
			
			var target:DisplayObjectContainer = null;
			for each( target in targets )
			{
				if( target is type )
				{
					ancestor = target;
					break;
				}
			}
			return ancestor;
		}
		
		public function get parents():Vector.<DisplayObjectContainer>
		{
			if( _parents != null )
			{
				return _parents;
			}
			
			var output:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
			var p:DisplayObjectContainer = this.parent;
			while( p != null )
			{
				//trace("AbstractComponent::added() adding parent reference: ", p );
				output.push( p );
				p = p.parent;
			}
			
			//trace("AbstractComponent::get parents()", "GOT PARENTS: ", this, output );
			
			//reverse the output so the parents are stored with
			//the stage at index zero the dirent parent being
			//the last element
			output.reverse();
			return output;
		}
		
		protected function addedToStage( event:Event ):void
		{
			//
			if( event.target == this
				&& this.parent != null
				&& this.stage != null
			 	&& this.root != null )
			{
				_parents = this.parents;
				//trace("AbstractComponent::addedToStage()", this, _parents );
				
				/*
				trace("UIComponent::finalized() FINALIZED stage/this/name string:::::: ",
					stage, this, this.toNameString() );				
				*/
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
		*	By default this implemention does nothing.
		*/
		internal function removed():void
		{
			//removeChildren();
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
		
		/**
		* 	Performs clean up of this instance.
		* 
		* 	The implementation of this method should clean any
		* 	event listeners and null any references to complex objects.
		*/
		public function destroy():void
		{
			_margins = null;
			_paddings = null;
			_border = null;
			_id = null;
			_extra = null;
			_border = null;
			_background = null;
			_styles = null;
			_customData = null;
			_identifier = null;
			_messages = null;			
			_parents = null;
			_class = null;
		}
	}
}