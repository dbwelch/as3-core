package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.layout.CellLayout;
	
	/**
	*	Represents a cell that can position
	*	a child components to the center or
	*	to an edge.
	*	
	*	Typically this would be used with a single
	*	component although if you add more children
	*	to this container they will also obey this
	*	cell's layout.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class Cell extends Canvas {
		
		private var _content:IComponent;
		
		/**
		*	Creates a <code>Cell</code> instance.
		*	
		*	@param width The preferred width of the cell.
		*	@param height The preferred height of the cell.
		*	@param content The initial content for the cell.
		*/
		public function Cell(
			width:Number = NaN,
			height:Number = NaN,
			content:IComponent = null )
		{
			super();
			this.layout = new CellLayout();
			this.width = width;
			this.height = height;
			this.content = content;
		}
		
		/**
		*	The content component for this cell.	
		*/
		public function get content():IComponent
		{
			return _content;
		}
		
		public function set content( content:IComponent ):void
		{
			if( this.content && content )
			{
				if( this.contains( DisplayObject( this.content ) ) )
				{
					removeChild( DisplayObject( this.content ) );
				}
			}
			
			_content = content;
			
			if( this.content )
			{
				addChild( DisplayObject( this.content ) );
			}
		}
	}
}