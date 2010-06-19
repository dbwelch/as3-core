package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	
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
	public class HorizontalLayout extends SpacingAwareLayout
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
		override public function added( child:DisplayObject ):void
		{
			var x:Number = 0;
			
			var previous:DisplayObject = getPreviousDisplayObject(
				child.parent, child );
				
			var spacing:Number = horizontalSpacing;

			if( previous is IMarginAware )
			{
				spacing += IMarginAware( previous ).margin.right;
			}

			if( child is IMarginAware )
			{
				spacing += IMarginAware( child ).margin.left;
			}
				
			if( previous )
			{
				x = previous.x + previous.width + spacing;
			}
			
			child.x = x;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function removed( child:DisplayObject ):void
		{
			//TODO
			trace("HorizontalLayout::removed(), ", child, child.parent );			
		}
	}
}