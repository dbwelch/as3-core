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
	public class BitmapFill extends Object {
			
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
		*	The bitmap data for the fill.
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
		*	The matrix to use when appling the fill.
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
		*	Whether the bitmap is repeated when applying
		*	the fill.	
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
		*	Whether the bitmap is smoothed when it is up-scaled.	
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
		* 	@inheritDoc
		*/
		public function apply(
			graphics:Graphics,
			component:IComponentGraphic ):void
		{
			if( graphics )
			{
				if( !bitmap )
				{
					throw new Error(
						"Cannot apply a bitmap fill with null bitmap data." );
				}
				
				graphics.beginBitmapFill(
					bitmap, matrix, repeat, smooth );
			}
		}
	}
}