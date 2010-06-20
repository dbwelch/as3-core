package com.ffsys.ui.layout {
	
	/**
	*	Represents the margins of a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Margin extends Edges
		implements IMargin {
		
		/**
		*	Creates a <code>Margin</code> instance.
		*	
		*	@param left A value for the left margin.
		*	@param top A value for the top margin.
		*	@param right A value for the right margin.
		*	@param bottom A value for the bottom margin.
		*/
		public function Margin(
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
		public function set margin( margin:Number ):void
		{
			_left = margin;
			_top = margin;
			_right = margin;
			_bottom = margin;
		}
	}
}