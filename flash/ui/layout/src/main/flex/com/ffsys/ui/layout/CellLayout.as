package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.common.Edges;
	
	/**
	*	Handles laying out the content of a cell.
	*	
	*	By default alignment is centered vertically
	*	and horizontally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class CellLayout extends Layout
	{	
		private var _horizontalAlign:String;
		private var _verticalAlign:String;
		
		/**
		* 	Creates a <code>CellLayout</code> instance.
		*	
		*	@param horizontalAlign The horizontal alignment.
		*	@param verticalAlign The vertical alignment.
		*/
		public function CellLayout(
			horizontalAlign:String = Edges.CENTER,
			verticalAlign:String = Edges.CENTER )
		{
			super();
			this.horizontalAlign = horizontalAlign;
			this.verticalAlign = verticalAlign;
		}
		
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign( value:String ):void
		{
			_horizontalAlign = value;
		}
		
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign( value:String ):void
		{
			_verticalAlign = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChild(
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):void
		{
			var x:Number = 0;
			var y:Number = 0;
			
			var parentWidth:Number = parent.width;
			var parentHeight:Number = parent.height;
			
			var childWidth:Number = child.width;
			var childHeight:Number = child.height;
			
			if( parent is ILayoutWidth )
			{
				parentWidth = ILayoutWidth( parent ).layoutWidth;
			}
			
			if( parent is ILayoutHeight )
			{
				parentHeight = ILayoutHeight( parent ).layoutHeight;
			}
			
			if( child is ILayoutWidth )
			{
				childWidth = ILayoutWidth( child ).layoutWidth;
			}
			
			if( child is ILayoutHeight )
			{
				childHeight = ILayoutHeight( child ).layoutHeight;
			}
			
			if( this.horizontalAlign == Edges.CENTER )
			{
				x = ( parentWidth / 2 ) - ( childWidth / 2 );
			}
			
			if( this.verticalAlign == Edges.CENTER )
			{
				y = ( parentHeight / 2 ) - ( childHeight / 2 );
			}
			
			child.x = x;
			child.y = y;
		}
	}
}