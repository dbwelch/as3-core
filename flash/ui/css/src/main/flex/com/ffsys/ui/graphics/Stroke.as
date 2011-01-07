package com.ffsys.ui.graphics {
	
	import flash.display.Graphics;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	/**
	*	Represents a stroke.
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
		* 
		* 	@param thickness The stroke thickness.
		* 	@param color The colour of the stroke.
		* 	@param alpha The alpha of the stroke.
		* 	@param pixelHinting Whether pixel hinting is enabled.
		* 	@param scaleMode The scale mode.
		* 	@param caps The caps mode.
		* 	@param joints The mode for joint rendering.
		* 	@param miterLimit The miter limit.
		*/
		public function Stroke(
			thickness:Number = 1,
			color:uint = 0xffffff,
			alpha:Number = 1,
			pixelHinting:Boolean = true,
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
			component:IComponentGraphic,
			width:Number,
			height:Number ):void
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
					gradient.stroke( graphics, width, height );
				}
			}
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return Stroke;
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
		* 	@inheritDoc
		*/
		public function clone():IStroke
		{
			var stroke:IStroke =
				IStroke( getCloneInstance() );
			stroke.thickness = this.thickness;
			stroke.color = this.color;
			stroke.alpha = this.alpha;
			stroke.pixelHinting = this.pixelHinting;
			stroke.scaleMode = this.scaleMode;
			stroke.caps = this.caps;
			stroke.joints = this.joints;
			stroke.miterLimit = this.miterLimit;
			return stroke;
		}
	}
}