package com.ffsys.ui.graphics {
	
	/**
	*	Description
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author 
	*	@since  19.06.2010
	*/
	public interface IFill
		extends IGraphicElement,
				IGradientAware {
		
		/**
		* 	The color for the fill.
		*/
		function get color():Number;
		function set color( color:Number ):void;
		
		/**
		* 	The alpha for the fill.
		*/
		function get alpha():Number;
		function set alpha( alpha:Number ):void;
	}
}