package com.ffsys.ui.graphics {
	
	/**
	*	Describes the contract for solid fills.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface ISolidFill
		extends IFill {
		
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