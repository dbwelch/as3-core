package org.flashx.ui.graphics {
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	/**
	*	Describes the contract for bitmap fills.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface IBitmapFill
		extends IFill {
		
		/**
		*	The bitmap data for the fill.
		*/
		function get bitmap():BitmapData;
		function set bitmap( bitmap:BitmapData ):void;
		
		/**
		*	The matrix to use when appling the fill.
		*/		
		function get matrix():Matrix;
		function set matrix( matrix:Matrix ):void;
		
		/**
		*	Whether the bitmap is repeated when applying
		*	the fill.
		*/
		function get repeat():Boolean;
		function set repeat( repeat:Boolean ):void;
		
		/**
		*	Whether the bitmap is smoothed when it is up-scaled.	
		*/
		function get smooth():Boolean;
		function set smooth( smooth:Boolean ):void;
		
		/**
		*	The angle for the bitmap fill in degrees.	
		*/
		function get angle():Number;
		function set angle( angle:Number ):void;		
	}
}