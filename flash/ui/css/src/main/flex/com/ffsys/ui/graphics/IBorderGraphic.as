package com.ffsys.ui.graphics
{
	import com.ffsys.ui.common.IBorder;
	
	/**
	*	Describes the contract for graphics that represent
	* 	a border.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.01.2011
	*/
	public interface IBorderGraphic
		extends IPointerAwareGraphic
	{
		/**
		* 	The border definition to use when drawing
		* 	the border edges.
		*/
		function get border():IBorder;
		function set border( value:IBorder ):void;
	}
}