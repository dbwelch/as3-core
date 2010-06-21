package com.ffsys.ui.common {
	
	/**
	*	Represents the padding of a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Padding extends Edges
		implements IPadding {
		
		/**
		*	Creates a <code>Padding</code> instance.
		*	
		*	@param left A value for the left padding.
		*	@param top A value for the top padding.
		*	@param right A value for the right padding.
		*	@param bottom A value for the bottom padding.
		*/
		public function Padding(
			left:Number = 0,
			top:Number = 0,
			right:Number = 0,
			bottom:Number = 0 )
		{
			super( left, top, right, bottom );
		}
		
		/**
		*	@inheritDoc
		*/
		public function set padding( padding:Number ):void
		{
			_left = padding;
			_top = padding;
			_right = padding;
			_bottom = padding;
		}		
	}
}