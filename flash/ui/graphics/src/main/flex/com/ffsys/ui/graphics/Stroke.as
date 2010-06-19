package com.ffsys.ui.graphics {
	
	import flash.display.Graphics;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	/**
	*	Represents a solid stroke.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Stroke extends Object
		implements IStroke {
			
		private var _gradient:IGradient;
		private var _thickness:Number;
		private var _color:Number;
		private var _alpha:Number;
		private var _pixelHinting:Boolean;
		private var _scaleMode:String;
		private var _caps:String;
		private var _joints:String;
		private var _miterLimit:Number;
		
		/**
		*	Creates a <code>Stroke</code> instance.
		*/
		public function Stroke(
			thickness:Number = 1,
			color:uint = 0x999999,
			alpha:Number = 1,
			pixelHinting:Boolean = false,
			scaleMode:String = LineScaleMode.NORMAL,
			caps:String = null,
			joints:String = null,
			miterLimit:Number = 3 )
		{
			super();
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
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
		public function get alpha():Number
		{
			return _alpha;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set alpha( alpha:Number ):void
		{
			_alpha = alpha;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get pixelHinting():Boolean
		{
			return _pixelHinting;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set pixelHinting( val:Boolean ):void
		{
			_pixelHinting = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get scaleMode():String
		{
			return _scaleMode;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set scaleMode( val:String ):void
		{
			_scaleMode = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get caps():String
		{
			return _caps;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set caps( val:String ):void
		{
			_caps = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get joints():String
		{
			return _joints;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set joints( val:String ):void
		{
			_joints = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get miterLimit():Number
		{
			return _miterLimit;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set miterLimit( val:Number ):void
		{
			_miterLimit = val;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get gradient():IGradient
		{
			return _gradient;
		}
		
		public function set gradient( gradient:IGradient ):void
		{
			_gradient = gradient;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function apply(
			graphics:Graphics,
			component:IComponentGraphic ):void
		{
			if( graphics )
			{
				graphics.lineStyle(
					thickness,
					color,
					alpha,
					pixelHinting,
					scaleMode,
					caps,
					joints,
					miterLimit );
				
				//override with the gradient if available
				if( gradient )
				{
					graphics.lineGradientStyle(
						gradient.type,
						gradient.colors,
						gradient.alphas,
						gradient.ratios,
						gradient.matrix,
						gradient.spreadMethod,
						gradient.interpolationMethod,
						gradient.focalPointRatio );
				}
			}
		}
	}
}