package org.flashx.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.flashx.ui.common.Orientation;
	import org.flashx.ui.common.IPaddingAware;
	
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
		/**
		* 	Creates a <code>CellLayout</code> instance.
		*	
		*	@param horizontalAlign The horizontal alignment.
		*	@param verticalAlign The vertical alignment.
		*/
		public function CellLayout(
			horizontalAlign:String = Orientation.CENTER,
			verticalAlign:String = Orientation.CENTER )
		{
			super();
			this.horizontalAlign = horizontalAlign;
			this.verticalAlign = verticalAlign;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChild(
			index:int,
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):void
		{
			var x:Number = 0;
			var y:Number = 0;
			
			var parentWidth:Number = parent.width;
			var parentHeight:Number = parent.height;
			
			var padded:IPaddingAware = parent as IPaddingAware;
			
			var pl:Number = 0;			
			var pt:Number = 0;
			var pr:Number = 0;
			var pb:Number = 0;
			
			if( padded )
			{
				pl = padded.paddings.left;
				pt = padded.paddings.top;
				pr = padded.paddings.right;
				pb = padded.paddings.bottom;
			}
			
			x = pl;
			y = pt;			
			
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
			
			if( this.horizontalAlign == Orientation.CENTER )
			{
				x = ( parentWidth / 2 ) - ( childWidth / 2 );
			}else if( this.horizontalAlign == Orientation.RIGHT )
			{
				x = parentWidth - ( childWidth + pr );
			}
			
			if( this.verticalAlign == Orientation.CENTER )
			{
				y = ( parentHeight / 2 ) - ( childHeight / 2 );
			}else if( this.verticalAlign == Orientation.BOTTOM )
			{
				y = parentHeight - ( childHeight + pb );
			}
			
			child.x = x;
			child.y = y;
			
			/*
			trace("CellLayout::layoutChild(), ",
				child, parentWidth, parentHeight, childWidth, childHeight, x, y );
			*/
		}
	}
}