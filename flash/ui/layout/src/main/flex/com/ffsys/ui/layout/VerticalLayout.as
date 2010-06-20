package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
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
		override protected function layoutChild(
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):void
		{
			var y:Number = 0;

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
				
				var index:int = previous.parent.getChildIndex( previous );
				
				if( !isNaN( size ) )
				{
					y = index * size;
				}else if( previous is ILayoutHeight )
				{
					height = ILayoutHeight( previous ).layoutHeight;
					y = previous.y + height + spacing;
				}else{
					y = previous.y + height + spacing;
				}
			}
			
			child.y = y;		
		}
	}
}