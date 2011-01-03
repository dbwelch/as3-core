package com.ffsys.ui.display
{
	
	/**
	*	Represents a vertical graphical rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.01.2011
	*/
	public class VerticalRule extends Divider
	{
		/**
		* 	Creates a <code>VerticalRule</code> instance.
		*/
		public function VerticalRule(
			width:Number = NaN,
			height:Number = NaN )
		{
			super( width, height );
			this.vertical = true;
		}
	}
}