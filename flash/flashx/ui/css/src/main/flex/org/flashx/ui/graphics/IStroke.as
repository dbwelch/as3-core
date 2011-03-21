package org.flashx.ui.graphics {
	
	import org.flashx.core.IClone;
	
	/**
	*	Describes the contract for graphic elements
	*	that represent a stroke.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public interface IStroke
		extends IGraphicElement,
		 		IGradientAware,
				IClone {
		
		/**
		*	@inheritDoc 
		*/
		function get thickness():Number;
		function set thickness( thickness:Number ):void;

		/**
		*	@inheritDoc 
		*/
		function get color():Number;
		function set color( color:Number ):void;

		/**
		* 	@inheritDoc
		*/
		function get alpha():Number;
		function set alpha( alpha:Number ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get pixelHinting():Boolean;
		function set pixelHinting( val:Boolean ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get scaleMode():String;
		function set scaleMode( val:String ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get caps():String;
		function set caps( val:String ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get joints():String;
		function set joints( val:String ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get miterLimit():Number;
		function set miterLimit( val:Number ):void;
		
		/**
		* 	Creates a clone of this stroke.
		* 
		* 	@return A clone of this stroke.
		*/
		function clone():IStroke;
	}
}