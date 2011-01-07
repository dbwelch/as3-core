package com.ffsys.ui.graphics
{
	import flash.display.Shape;
	import flash.geom.Point;
	
	import com.ffsys.ui.common.IMargin;
	import com.ffsys.ui.common.IPadding;	
	import com.ffsys.ui.common.Margin;
	import com.ffsys.ui.common.Padding;
	
	import com.ffsys.ui.css.IStyleManagerAware;	
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.StyleManager;
	
	/**
	*	Abstract super class for component graphics.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class ComponentGraphic extends Shape
		implements 	IComponentGraphic,
					IStyleManagerAware
	{
		/**
		*	@private
		*/
		private var _styleManager:IStyleManager = null;
		
		private var _id:String;
		private var _preferredWidth:Number;
		private var _preferredHeight:Number;
		private var _tx:Number = 0;
		private var _ty:Number = 0;
		private var _stroke:IStroke = null;
		private var _fill:IFill = null;
		
		private var _strokeApplied:Boolean;
		private var _fillApplied:Boolean;
		
		//TODO: deprecate
		private var _margins:IMargin = new Margin();
		private var _paddings:IPadding = new Padding();		
		private var _styles:String;
		
		/**
		* 	Creates a <code>ComponentGraphic</code> instance.
		* 
		* 	@param preferredWidth The preferred width to use when drawing.
		* 	@param preferredHeight The preferred height to use when drawing.
		*	@param stroke The stroke for the graphic.
		*	@param fill The fill for the graphic.
		*	@param tx The x translation.
		*	@param ty The y translation.
		*/
		public function ComponentGraphic(
			preferredWidth:Number = 25,
			preferredHeight:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			tx:Number = 0,
			ty:Number = 0 )
		{
			super();
			this.preferredWidth = preferredWidth;
			this.preferredHeight = preferredHeight;
			this.stroke = stroke;
			this.fill = fill;
			this.tx = tx;
			this.ty = ty;
		}
		
		/**
		* 	An identifier for this graphic.
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
		* 	The style manager for the graphic components.
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
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
		* 	@inheritDoc
		*/
		public function applyStyles():Array
		{
			//trace("ComponentGraphic::applyStyles()", styleManager );
			if( styleManager )
			{
				var styleNames:Array = styleManager.getStyleNameList( this );
				//trace("ComponentGraphic::applyStyles()", styleNames );
				return styleManager.style( this );
			}
			return null;
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
		public function get paddings():IPadding
		{
			return _paddings;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get layoutWidth():Number
		{
			//return this.preferredWidth;
			
			return this.getRect( this.parent ).width;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get layoutHeight():Number
		{
			//return this.preferredHeight;
			
			return this.getRect( this.parent ).height;
		}
		
		/**
		*	@inheritDoc 
		*/		
		public function get preferredWidth():Number
		{
			return _preferredWidth;
		}
		
		public function set preferredWidth( preferredWidth:Number ):void
		{
			_preferredWidth = preferredWidth;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get preferredHeight():Number
		{
			return _preferredHeight;
		}
		
		public function set preferredHeight( preferredHeight:Number ):void
		{
			_preferredHeight = preferredHeight;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get tx():Number
		{
			return _tx;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set tx( tx:Number ):void
		{
			_tx = tx;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get ty():Number
		{
			return _ty;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set ty( ty:Number ):void
		{
			_ty = ty;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get stroke():IStroke
		{
			return _stroke;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set stroke( stroke:IStroke ):void
		{
			_stroke = stroke;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get fill():IFill
		{
			return _fill;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set fill( fill:IFill ):void
		{
			_fill = fill;
		}
		
		/**
		*	@inheritDoc
		*/
		public function redraw():void
		{
			draw( preferredWidth, preferredHeight );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function draw( width:Number = NaN, height:Number = NaN ):void
		{
			graphics.clear();
			
			if( isNaN( width ) )
			{
				width = preferredWidth;
			}
			
			if( isNaN( height ) )
			{
				height = preferredHeight;
			}
			
			_strokeApplied = false;
			_fillApplied = false;
			
			beforeDraw( width, height );
			doDraw( width, height );
			afterDraw( width, height );
		}
		
		/**
		*	@inheritDoc
		*/
		public function setSize(
			width:Number, height:Number ):void
		{
			preferredWidth = width;
			preferredHeight = height;
			draw( width, height );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function render( width:Number, height:Number ):void
		{
			doDraw( width, height );
		}		
		
		/**
		*	Invoked before drawing occurs, used to set up the graphics
		* 	stroke and fill.
		*/
		private function beforeDraw( width:Number, height:Number ):void
		{
			_strokeApplied = applyStroke( width, height );
			_fillApplied = applyFill( width, height );
		}
		
		/**
		*	Performs the main drawing routine.
		*	
		*	Does nothing by default.
		*/
		protected function doDraw( width:Number, height:Number ):void
		{
			//
		}
		
		/**
		*	Invoked after drawing occurs.
		*	
		*	By default this simply ends the fill to render
		*	any fill.
		*/
		protected function afterDraw( width:Number, height:Number ):void
		{
			if( fill && _fillApplied )
			{
				graphics.endFill();
			}
		}
		
		/**
		*	Applies the stroke for the shape.
		*/		
		protected function applyStroke( width:Number, height:Number ):Boolean
		{
			if( stroke )
			{
				stroke.apply( graphics, this, width, height );
				return true;
			}
			return false;
		}
		
		/**
		*	Applies the stroke for the shape.
		*/		
		protected function applyFill( width:Number, height:Number ):Boolean
		{
			if( fill )
			{
				fill.apply( graphics, this, width, height );
				return true;
			}
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function lineTo( point:Point ):void
		{
			if( point )
			{
				graphics.lineTo( point.x, point.y );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function moveTo( point:Point ):void
		{
			if( point )
			{
				graphics.moveTo( point.x, point.y );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function curveTo( control:Point, anchor:Point ):void
		{
			if( control && anchor )
			{
				graphics.curveTo( control.x, control.y, anchor.x, anchor.y );
			}
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return ComponentGraphic;
		}
		
		/**
		* 	Gets an instance for use as a clone.
		* 
		* 	@return The instance to use as a clone.
		*/
		public function getCloneInstance():Object
		{
			var clazz:Class = getCloneClass();
			return new clazz();
		}
		
		/**
		* 	Creates a clone of this graphic.
		* 
		* 	@return A clone of this graphic.
		*/
		public function clone():IComponentGraphic
		{
			var graphic:IComponentGraphic =
				IComponentGraphic( getCloneInstance() );
			graphic.preferredWidth = preferredWidth;
			graphic.preferredHeight = preferredHeight;
			graphic.tx = tx;
			graphic.ty = ty;
			graphic.id = this.id;
			if( fill != null )
			{
				graphic.fill = fill.clone();
			}
			if( stroke != null )
			{
				graphic.stroke = stroke.clone();			
			}
			return graphic;			
		}
	}
}