package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.layout.CellLayout;
	
	/**
	*	Represents a cell that can position
	*	a single child component to the center or
	*	to an edge.
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
		*	@param content The cell contents.
		*	@param width The preferred width of the cell.
		*	@param height The preferred height of the cell.
		*/
		public function Cell(
			content:IComponent = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
			this.layout = new CellLayout();
			this.preferredWidth = width;
			this.preferredHeight = height;
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
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutWidth():Number
		{
			if( isNaN( this.preferredWidth ) && content ) 
			{
				return content.width;
			}

			return super.layoutWidth;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutHeight():Number
		{
			if( isNaN( this.preferredHeight ) && content ) 
			{
				return content.height;
			}

			return super.layoutHeight;
		}
	}
}