package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	
	/**
	*	Handles laying out components in a vertical
	*	manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class VerticalLayout extends Layout
	{	
		/**
		* 	Creates a <code>VerticalLayout</code> instance.
		*/
		public function VerticalLayout()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set spacing( spacing:Number ):void
		{
			this.verticalSpacing = spacing;
			super.spacing = spacing;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function added( child:DisplayObject ):void
		{
			var y:Number = 0;
			
			var previous:DisplayObject = getPreviousDisplayObject(
				child.parent, child );
				
			var spacing:Number = verticalSpacing;
			
			if( previous is IMarginAware )
			{
				spacing += IMarginAware( previous ).margins.bottom;
			}
			
			if( child is IMarginAware )
			{
				spacing += IMarginAware( child ).margins.top;
			}
				
			if( previous )
			{
				var height:Number = previous.height;
				
				
				if( previous is ILayoutHeight )
				{
					height = ILayoutHeight( previous ).layoutHeight;
				}
				
				
				//trace("VerticalLayout::added(), previous height: ", height );
				
				y = previous.y + height + spacing;
			}
			
			child.y = y;
			
			//trace("VerticalLayout::added(), ", child, spacing, child.y );			
		}
		
		/**
		*	@inheritDoc
		*/
		override public function removed( child:DisplayObject ):void
		{
			//TODO
			trace("VerticalLayout::removed(), ", child, child.parent );
		}
	}
}