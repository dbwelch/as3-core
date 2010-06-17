package com.ffsys.ui.graphics
{
	import flash.display.Shape;
	
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
		implements IComponentGraphic
	{
		private var _targetWidth:Number;
		private var _targetHeight:Number;
		
		private var _tx:Number = 0;
		private var _ty:Number = 0;
		
		private var _stroke:Boolean = false;
		private var _thickness:Number = 1;
		private var _color:Number = 0xa9a9a9;
		private var _opacity:Number = 1;
		private var _fill:IGraphicFill = new SolidFill( 0x232021 );
		
		/**
		* 	Creates a <code>ComponentGraphic</code> instance.
		* 
		* 	@param targetWidth The target width to use when drawing.
		* 	@param targetHeight The target height to use when drawing.
		*/
		public function ComponentGraphic(
			targetWidth:Number = 25,
			targetHeight:Number = 25 )
		{
			super();
			this.targetWidth = targetWidth;
			this.targetHeight = targetHeight;
		}
		
		public function get targetWidth():Number
		{
			return _targetWidth;
		}
		
		public function set targetWidth( targetWidth:Number ):void
		{
			_targetWidth = targetWidth;
		}
		
		public function get targetHeight():Number
		{
			return _targetHeight;
		}
		
		public function set targetHeight( targetHeight:Number ):void
		{
			_targetHeight = targetHeight;
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
		public function get stroke():Boolean
		{
			return _stroke;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set stroke( stroke:Boolean ):void
		{
			_stroke = stroke;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get thickness():Number
		{
			return _thickness;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set thickness( thickness:Number ):void
		{
			_thickness = thickness;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get color():Number
		{
			return _color;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set color( color:Number ):void
		{
			_color = color;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get opacity():Number
		{
			return _opacity;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set opacity( opacity:Number ):void
		{
			_opacity = opacity;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function get fill():IGraphicFill
		{
			return _fill;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function set fill( fill:IGraphicFill ):void
		{
			_fill = fill;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function draw( width:Number = NaN, height:Number = NaN ):void
		{
			if( isNaN( width ) )
			{
				width = targetWidth;
			}
			
			if( isNaN( height ) )
			{
				height = targetHeight;
			}
			
			beforeDraw( width, height );
			doDraw( width, height );
			afterDraw( width, height );
		}
		
		/**
		*	Invoked before drawing occurs, used to set up the graphics
		* 	stroke and fill. 
		*/
		protected function beforeDraw( width:Number, height:Number ):void
		{
			if( stroke && thickness > 0 )
			{
				graphics.lineStyle( thickness, color, opacity );
			}
			
			if( fill )
			{
				fill.apply( graphics );
			}
		}
		
		/**
		*	Performs the main drawing routine.
		*/
		protected function doDraw( width:Number, height:Number ):void
		{
			//
		}
		
		/**
		*	Invoked after drawing occurs, used to end any fill.
		*/
		protected function afterDraw( width:Number, height:Number ):void
		{
			if( fill )
			{
				graphics.endFill();
			}
		}
	}
}