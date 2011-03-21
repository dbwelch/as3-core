package org.flashx.ui.common {
	
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
		*	@param top A value for the top margin.
		*	@param right A value for the right margin.
		*	@param bottom A value for the bottom margin.
		*	@param left A value for the left margin.
		*/
		public function Margin(
			top:Number = 0,
			right:Number = 0,
			bottom:Number = 0,
			left:Number = 0 )
		{
			super( top, right, bottom, left );
		}
		
		/**
		*	@inheritDoc
		*/
		public function set margin( margin:Number ):void
		{
			_top = margin;
			_right = margin;
			_bottom = margin;
			_left = margin;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return Margin;
		}		
	}
}