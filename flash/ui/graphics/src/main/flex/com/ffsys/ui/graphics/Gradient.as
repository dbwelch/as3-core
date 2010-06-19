package com.ffsys.ui.graphics {
	
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	/**
	*	Represents the properties for a gradient.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Gradient extends Object
		implements IGradient {
		
		private var _type:String;
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _matrix:Matrix;
		private var _spreadMethod:String;
		private var _interpolationMethod:String;
		private var _focalPointRatio:Number = 0;
		
		/**
		*	Creates an <code>Gradient</code> instance.
		*/
		public function Gradient(
			type:String = GradientType.LINEAR,
			colors:Array = null,
			alphas:Array = null,
			ratios:Array = null,
			matrix:Matrix = null,
			spreadMethod:String = SpreadMethod.PAD,
			interpolationMethod:String = InterpolationMethod.RGB,
			focalPointRatio:Number = 0 )
		{
			super();
			
			if( !colors )
			{
				colors = [ 0xffffff, 0x000000 ];
			}
			
			if( !alphas )
			{
				alphas = [ 1, 1 ];
			}
			
			if( !ratios )
			{
				ratios = [ 0, 255 ];
			}
			
			if( !matrix )
			{
				matrix = new Matrix();
				//TODO: implement default linear rotation
				//matrix.rotate(  );
			}
			
			this.type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.matrix = matrix;
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get type():String
		{
			return _type;
		}
		
		public function set type( type:String ):void
		{
			_type = type;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get colors():Array
		{
			return _colors;
		}
		
		public function set colors( val:Array ):void
		{
			_colors = val;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get alphas():Array
		{
			return _alphas;
		}
		
		public function set alphas( alphas:Array ):void
		{
			_alphas = alphas;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get ratios():Array
		{
			return _ratios;
		}
		
		public function set ratios( ratios:Array ):void
		{
			_ratios = ratios;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get matrix():Matrix
		{
			return _matrix;
		}
		
		public function set matrix( matrix:Matrix ):void
		{
			_matrix = matrix;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get spreadMethod():String
		{
			return _spreadMethod;
		}
		
		public function set spreadMethod(
			spreadMethod:String ):void
		{
			_spreadMethod = spreadMethod;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get interpolationMethod():String
		{
			return _interpolationMethod;
		}
		
		public function set interpolationMethod(
			interpolationMethod:String ):void
		{
			_interpolationMethod = interpolationMethod;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get focalPointRatio():Number
		{
			return _focalPointRatio;
		}
		
		public function set focalPointRatio(
			focalPointRatio:Number ):void
		{
			_focalPointRatio = focalPointRatio;
		}
	}
}