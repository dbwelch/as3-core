package org.flashx.ui.graphics {
	
	import flash.display.Graphics;
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
		
		private var _type:String = GradientType.LINEAR;
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _matrix:Matrix;
		private var _spreadMethod:String = SpreadMethod.PAD;
		private var _interpolationMethod:String = InterpolationMethod.RGB;
		private var _focalPointRatio:Number = 0;
		private var _angle:Number = 90;
		
		/**
		*	Creates an <code>Gradient</code> instance.
		*/
		public function Gradient(
			type:String = null,
			colors:Array = null,
			alphas:Array = null,
			ratios:Array = null,
			matrix:Matrix = null,
			spreadMethod:String = null,
			interpolationMethod:String = null,
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
			
			if( type != null )
			{
				this.type = type;
			}
			
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.matrix = matrix;
			
			if( spreadMethod != null )
			{
				this.spreadMethod = spreadMethod;
			}
			
			if( interpolationMethod != null )
			{
				this.interpolationMethod = interpolationMethod;
			}
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
		
		/**
		*	@inheritDoc	
		*/
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle( angle:Number ):void
		{
			_angle = angle;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function stroke(
			graphics:Graphics,
			width:Number,
			height:Number ):void
		{
			if( graphics )
			{
				createGradientBox( width, height );
				
				graphics.lineGradientStyle(
					type,
					colors,
					alphas,
					ratios,
					matrix,
					spreadMethod,
					interpolationMethod,
					focalPointRatio );
			}
		}
		
		/**
		*	@inheritDoc	
		*/	
		public function fill(
			graphics:Graphics,
			width:Number,
			height:Number ):void
		{
			if( graphics )
			{
				createGradientBox( width, height );
				
				graphics.beginGradientFill(
					type,
					colors,
					alphas,
					ratios,
					matrix,
					spreadMethod,
					interpolationMethod,
					focalPointRatio );
			}
		}
		
		/**
		*	@private	
		*/
		private function createGradientBox( width:Number, height:Number ):void
		{
			if( !matrix )
			{
				matrix = new Matrix();
			}
			
			var radians:Number = 0;
			
			if( !isNaN( angle ) )
			{
				radians = angle * Math.PI / 180;
			}
			
			matrix.createGradientBox( width, height, radians, 0, 0 );			
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return Gradient;
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
		public function clone():IGradient
		{
			var gradient:IGradient =
				IGradient( getCloneInstance() );
				
			gradient.type = this.type;
			
			gradient.colors = this.colors.slice();
			gradient.alphas = this.alphas.slice();
			gradient.ratios = this.ratios.slice();
			//TODO: clone the matrix
			gradient.matrix = this.matrix;
			gradient.spreadMethod = this.spreadMethod;
			gradient.interpolationMethod = this.interpolationMethod;
			gradient.focalPointRatio = this.focalPointRatio;
			return gradient;
		}
	}
}