package org.flashx.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.flashx.ui.common.*;
	
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
			index:int,
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):void
		{
			var parentPaddingAware:IPaddingAware = parent as IPaddingAware;
			var parentBorderAware:IBorderAware = parent as IBorderAware;
			
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
			
			var isFirst:Boolean = ( index == 0 && parent.getChildIndex( child ) == 0 );		
			var y:Number = 0;
	
			if( parentBorderAware != null )
			{
				child.x += parentBorderAware.border.left;				
			}
				
			if( !isFirst
				&& previous != null )
			{
				var spacing:Number = verticalSpacing;
				
				/*
				if( previous is IMarginAware && !collapsed )
				{
					spacing += IMarginAware( previous ).margins.bottom;
				}
				*/
				
			
				var previousMargin:IMarginAware = getPreviousMargin( previous );
			
				//deal with margins as the last child of a previous sibling
				if( previousMargin != null )
				{
					spacing += previousMargin.margins.bottom;
				}	
				
				if( child is IMarginAware && !collapsed )
				{
					spacing += IMarginAware( child ).margins.top;
				}				
				
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
				//no previous element and not collapsed obey paddings
				if( parentPaddingAware != null )
				{
					y = parentPaddingAware.paddings.top;
				}
				
				if( child is IMarginAware )
				{
					y += IMarginAware( child ).margins.top;
				}
				
				if( parentBorderAware != null )
				{
					y += parentBorderAware.border.top;
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