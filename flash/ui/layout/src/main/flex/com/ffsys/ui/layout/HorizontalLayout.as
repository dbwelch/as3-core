package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	*	Handles laying out components in a horizontal
	*	manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class HorizontalLayout extends Layout
	{	
		/**
		* 	Creates a <code>HorizontalLayout</code> instance.
		*/
		public function HorizontalLayout()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set spacing( spacing:Number ):void
		{
			this.horizontalSpacing = spacing;
			super.spacing = spacing;
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
				
			var spacing:Number = horizontalSpacing;

			if( previous is IMarginAware )
			{
				spacing += IMarginAware( previous ).margins.right;
			}

			if( child is IMarginAware )
			{
				spacing += IMarginAware( child ).margins.left;
			}
				
			if( previous )
			{
				var width:Number = previous.width;
				var index:int = previous.parent.getChildIndex( previous );
				
				if( !isNaN( size ) )
				{
					x = index * size;
				}else if( previous is ILayoutWidth )
				{
					width = ILayoutWidth( previous ).layoutWidth;
					x = previous.x + width + spacing;
				}else{
					x = previous.x + width + spacing;
				}
			}
			
			child.x = x;
		}
	}
}