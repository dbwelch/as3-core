package com.ffsys.ui.graphics {
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	*	Represents a bitmap fill.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class BitmapFill extends Object
		implements IBitmapFill {
			
		private var _angle:Number = 0;
		private var _bitmap:BitmapData;
		private var _matrix:Matrix;
		private var _repeat:Boolean = true;
		private var _smooth:Boolean = false;
		
		/**
		*	Creates a <code>BitmapFill</code> instance.
		*	
		*	@param bitmap The bitmap data for the fill.
		*	@param matrix A matrix to apply when creating the fill.
		*	@param repeat Whether the bitmap fill is repeated.
		*	@param smooth Determines the smoothing algorithm.
		*/
		public function BitmapFill(
			bitmap:BitmapData = null,
			matrix:Matrix = null,
			repeat:Boolean = true,
			smooth:Boolean = false )
		{
			super();
			this.bitmap = bitmap;
			this.matrix = matrix;
			this.repeat = repeat;
			this.smooth = smooth;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get bitmap():BitmapData
		{
			return _bitmap;
		}
		
		public function set bitmap( bitmap:BitmapData ):void
		{
			_bitmap = bitmap;
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
		public function get repeat():Boolean
		{
			return _repeat;
		}
		
		public function set repeat( repeat:Boolean ):void
		{
			_repeat = repeat;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get smooth():Boolean
		{
			return _smooth;
		}
		
		public function set smooth( smooth:Boolean ):void
		{
			_smooth = smooth;
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
				if( !bitmap )
				{
					throw new Error(
						"Cannot apply a bitmap fill with null bitmap data." );
				}
				
				var radians:Number = angle * Math.PI / 180;
				
				if( !matrix )
				{
					matrix = new Matrix();
				}
				
				matrix.rotate( radians );
				
				graphics.beginBitmapFill(
					bitmap, matrix, repeat, smooth );
			}
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return BitmapFill;
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
		public function clone():IFill
		{
			var bmp:IBitmapFill =
				IBitmapFill( getCloneInstance() );
			bmp.angle = this.angle;
			//TODO: clone the matrix
			bmp.matrix = this.matrix;
			bmp.repeat = this.repeat;
			bmp.smooth = this.smooth;
			if( this.bitmap != null )
			{
				bmp.bitmap = this.bitmap.clone();
			}
			return bmp;
		}
	}
}