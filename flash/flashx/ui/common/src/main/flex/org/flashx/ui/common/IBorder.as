package org.flashx.ui.common
{
	import org.flashx.ui.common.IEdges;
	
	/**
	*	Describes the contract for a css border definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.01.2011
	*/
	public interface IBorder extends IEdges
	{
		
		/**
		* 	A value for all borders.
		*/
		function set border( value:Number ):void;
				
		/**
		* 	A default colour to use when drawing the border.
		*/
		function get color():Number;
		function set color(value:Number):void;
		
		/**
		* 	A default alpha to use when drawing the border.
		*/
		function get alpha():Number;
		function set alpha( value:Number ):void;
	}
}