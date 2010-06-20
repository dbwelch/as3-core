package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.IComponent;
	
	/**
	*	Represents a cell that can position
	*	a child component to the center or
	*	to an edge.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class Cell extends Canvas {
		
		/**
		*	Creates a <code>Cell</code> instance.
		*	
		*	@param content The cell contents.
		*	@param width The width of the cell.
		*	@param height The height of the cell.
		*/
		public function Cell(
			content:IComponent = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
		}
		
		
	}
}