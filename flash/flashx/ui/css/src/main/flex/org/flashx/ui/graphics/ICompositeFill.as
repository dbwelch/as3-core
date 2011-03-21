package org.flashx.ui.graphics {
	
	/**
	*	Description
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author 
	*	@since  19.06.2010
	*/
	public interface ICompositeFill
		extends IFill {
					
		/**
		*	A solid fill to apply.
		*/
		function get solid():ISolidFill;
		function set solid( solid:ISolidFill ):void;
		
		/**
		*	A gradient fill to apply.
		*/
		function get gradient():IGradientFill;
		function set gradient( gradient:IGradientFill ):void;
		
		/**
		*	A bitmap fill to apply.
		*/
		function get bitmap():IBitmapFill;
		function set bitmap( bitmap:IBitmapFill ):void;
		
		/**
		*	The array of composite fills.
		*	
		*	If no custom composites have been defined then
		*	this returns an array between zero and three
		*	containing non-null solid, bitmap and gradient
		*	property values.
		*/
		function get composites():Array;
		function set composites( composites:Array ):void;
	}
}