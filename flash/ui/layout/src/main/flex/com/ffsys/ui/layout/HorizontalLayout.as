package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.common.IMarginAware;
	
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
		* 
		* 	@param spacing The spacing for this layout.
		*/
		public function HorizontalLayout( spacing:Number = 0 )
		{
			super();
			this.spacing = spacing;
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
			//we never layout fixed layout items
			if( child is IFixedLayout )
			{
				return;
			}
			
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
			}else
			{
				//no previous element and not collapsed obey margins
				if( !collapsed && ( child is IMarginAware ) )
				{
					x = IMarginAware( child ).margins.left;
				}
			}
			
			if( child is IMarginAware )
			{
				child.y = IMarginAware( child ).margins.top;
			}
			
			if( child is IAdjustLayoutValue )
			{
				x = Number( IAdjustLayoutValue( child ).adjustLayoutValue(
					this,
					x,
					parent,
					child,
					previous ) );
			}			
			
			child.x = x;
		}
	}
}