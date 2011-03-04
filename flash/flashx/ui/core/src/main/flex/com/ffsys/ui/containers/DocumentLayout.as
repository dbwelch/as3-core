package com.ffsys.ui.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.common.*;
	import com.ffsys.ui.layout.*;
	
	/*
	
	
	none	The element will generate no box at all
	block	The element will generate a block box (a line break before and after the element)
	inline	The element will generate an inline box (no line break before or after the element). This is default
	inline-block	The element will generate a block box, laid out as an inline box
	inline-table	The element will generate an inline box (like <table>, with no line break before or after)
	list-item	The element will generate a block box, and an inline box for the list marker
	run-in	The element will generate a block or inline box, depending on context
	table	The element will behave like a table (like <table>, with a line break before and after)
	table-caption	The element will behave like a table caption (like <caption>)
	table-cell	The element will behave like a table cell
	table-column	The element will behave like a table column
	table-column-group	The element will behave like a table column group (like <colgroup>)
	table-footer-group	The element will behave like a table footer row group
	table-header-group	The element will behave like a table header row group
	table-row	The element will behave like a table row
	table-row-group	The element will behave like a table row group
	inherit	Specifies that the value of the display property should be inherited from the parent element	
	
	
	
	
	
	*/
	
	/**
	*	Handles laying out components whose positions
	* 	are determined by css style properties.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class DocumentLayout extends Layout
	{	
		
		/**
		* 	Creates a <code>DocumentLayout</code> instance.
		* 
		* 	@param spacing The spacing for this layout.
		*/
		public function DocumentLayout( spacing:Number = 0 )
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