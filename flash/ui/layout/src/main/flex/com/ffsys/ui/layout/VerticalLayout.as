package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.common.*;
	
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
		* 
		* 	@param spacing The spacing for this layout.
		*/
		public function VerticalLayout( spacing:Number = 0 )
		{
			super();
			this.spacing = spacing;
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
			var parentPaddingAware:IPaddingAware = parent as IPaddingAware;
			
			if( parentPaddingAware != null )
			{
				child.x = parentPaddingAware.paddings.left;
				if( child is IMarginAware )
				{
					child.x += IMarginAware( child ).margins.left;
				}
			}else{			
				if( child is IMarginAware )
				{
					child.x = IMarginAware( child ).margins.left;
				}				
			}
			
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
				
			if( previous != null )
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
			}else
			{
				if( parentPaddingAware )
				{
					y = parentPaddingAware.paddings.top;
				}
				
				//no previous element and not collapsed obey margins
				if( !collapsed && ( child is IMarginAware ) )
				{
					y += IMarginAware( child ).margins.top;
				}
			}
			
			if( child is IAdjustLayoutValue )
			{
				y = Number( IAdjustLayoutValue( child ).adjustLayoutValue(
					this,
					y,
					parent,
					child,
					previous ) );
			}
			
			child.y = y;
		}
	}
}