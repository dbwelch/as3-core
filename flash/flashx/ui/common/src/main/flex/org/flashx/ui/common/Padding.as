package org.flashx.ui.common {
	
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
		*	@param top A value for the top padding.
		*	@param right A value for the right padding.
		*	@param bottom A value for the bottom padding.
		*	@param left A value for the left padding.
		*/
		public function Padding(
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
		public function set padding( padding:Number ):void
		{
			_top = padding;
			_right = padding;
			_bottom = padding;
			_left = padding;
		}
		
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return Padding;
		}		
	}
}