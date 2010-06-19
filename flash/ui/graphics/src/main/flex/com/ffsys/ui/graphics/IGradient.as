package com.ffsys.ui.graphics {
	
	import flash.geom.Matrix;
	
	/**
	*	Describes the contract for graphical elements
	*	that represent a gradient.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IGradient {
		
		
		/**
		*	@inheritDoc	
		*/
		function get type():String;
		function set type( type:String ):void;
		
		/**
		*	@inheritDoc	
		*/		
		function get colors():Array;
		function set colors( val:Array ):void;
		
		/**
		*	@inheritDoc	
		*/		
		function get alphas():Array;
		function set alphas( alphas:Array ):void;
		
		/**
		*	@inheritDoc	
		*/
		function get ratios():Array;
		function set ratios( ratios:Array ):void;
		
		/**
		*	@inheritDoc	
		*/
		function get matrix():Matrix;
		function set matrix( matrix:Matrix ):void;
		
		/**
		*	@inheritDoc	
		*/
		function get spreadMethod():String;
		function set spreadMethod(
			spreadMethod:String ):void;
			
		/**
		*	@inheritDoc	
		*/
		function get interpolationMethod():String;
		function set interpolationMethod(
			interpolationMethod:String ):void;
			
		/**
		*	@inheritDoc	
		*/
		function get focalPointRatio():Number;
		function set focalPointRatio(
			focalPointRatio:Number ):void;		
	}
}