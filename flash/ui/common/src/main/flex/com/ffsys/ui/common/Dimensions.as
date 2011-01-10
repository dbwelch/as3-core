package com.ffsys.ui.common
{
	import flash.geom.Rectangle;
	
	/**
	*	Represents the dimensions for a box model.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public class Dimensions extends Rectangle
		implements IDimensions
	{
		/*
		
		
		//WEB SAFE FONTS
		
		font-family: Arial, Helvetica, sans-serif;
		font-family: 'Arial Black', Gadget, sans-serif;
		font-family: 'Bookman Old Style', serif;
		font-family: 'Comic Sans MS', cursive;
		font-family: Courier, monospace;
		font-family: 'Courier New', Courier, monospace;
		font-family: Garamond, serif;
		font-family: Georgia, serif;
		font-family: Impact, Charcoal, sans-serif;
		font-family: 'Lucida Console', Monaco, monospace;
		font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;
		font-family: 'MS Sans Serif', Geneva, sans-serif;
		font-family: 'MS Serif', 'New York', sans-serif;
		font-family: 'Palatino Linotype', 'Book Antiqua', Palatino, serif;
		font-family: Symbol, sans-serif;
		font-family: Tahoma, Geneva, sans-serif;
		font-family: 'Times New Roman', Times, serif;
		font-family: 'Trebuchet MS', Helvetica, sans-serif;
		font-family: Verdana, Geneva, sans-serif;
		font-family: Webdings, sans-serif;
		font-family: Wingdings, 'Zapf Dingbats', sans-serif;		
		
		// FONT SIZE
		
		xx-small	Sets the font-size to an xx-small size
		x-small	Sets the font-size to an extra small size
		small	Sets the font-size to a small size
		medium	Sets the font-size to a medium size. This is default
		large	Sets the font-size to a large size
		x-large	Sets the font-size to an extra large size
		xx-large	Sets the font-size to an xx-large size
		smaller	Sets the font-size to a smaller size than the parent element
		larger	Sets the font-size to a larger size than the parent element
		length	Sets the font-size to a fixed size in px, cm, etc.
		%	Sets the font-size to a percent of  the parent element's font size
		inherit	Specifies that the font size should be inherited from the parent element		
		
		//WIDTH
		width Syntax:
		width: <length> | <percentage> | auto | inherit

		length
		A specific length (include unit of measure).
		percentage
		A percentage of the width of the parent element.
		auto
		Allows the user-agent to define the width based on inheritance and pre-set user-agent rules.
		inherit
		The element should have the same width setting as the parent.
		
		//UNITS
		
		%	percentage
		in	inch
		cm	centimeter
		mm	millimeter
		em	1em is equal to the current font size. 2em means 2 times the size of the current font. E.g., if an element is displayed with a font of 12 pt, then '2em' is 24 pt. The 'em' is a very useful unit in CSS, since it can adapt automatically to the font that the reader uses
		ex	one ex is the x-height of a font (x-height is usually about half the font-size)
		pt	point (1 pt is the same as 1/72 inch)
		pc	pica (1 pc is the same as 12 points)
		px	pixels (a dot on the computer screen)
		
		//COLORS
		
		Color Values

		Value	Description
		color_name	A color name (e.g. red)
		rgb(x,x,x)	An RGB value (e.g. rgb(255,0,0))
		rgb(x%, x%, x%)	An RGB percentage value (e.g. rgb(100%,0%,0%))
		#rrggbb	A HEX number (e.g. #ff0000)
		
		//OVERFLOW
		
		visible	The overflow is not clipped. It renders outside the element's box. This is default
		hidden	The overflow is clipped, and the rest of the content will be invisible
		scroll	The overflow is clipped, but a scroll-bar is added to see the rest of the content
		auto	If overflow is clipped, a scroll-bar should be added to see the rest of the content
		inherit	Specifies that the value of the overflow property should be inherited from the parent element
		
		//DISPLAY
		
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
		
		//vertical-align
		
		length	Raises or lower an element by the specified length. Negative values are allowed
		%	Raises or lower an element in a percent of the "line-height" property. Negative values are allowed
		baseline	Align the baseline of the element with the baseline of the parent element. This is default
		sub	Aligns the element as it was subscript
		super	Aligns the element as it was superscript
		top	The top of the element is aligned with the top of the tallest element on the line
		text-top	The top of the element is aligned with the top of the parent element's font
		middle	The element is placed in the middle of the parent element
		bottom	The bottom of the element is aligned with the lowest element on the line
		text-bottom	The bottom of the element is aligned with the bottom of the parent element's font
		inherit	Specifies that the value of the vertical-align property should be inherited from the parent element	
		
		
		//text-justify
		
		auto	The browser will determine the appropriate justification algorithm to use
		distribute	Justification is handled similarly to the “newspaper” value, but this version is optimized for East Asian content (especially the Thai language.) In this justification method, the last line is not justified.
		distribute-all-lines	Behavior and intent for this value is the same as with the “distribute” value, but the last line is also justified.
		inter-cluster	Justifies content that does not have any inter-word spacing (such as with many East Asian languages.)
		inter-ideograph	Used for justifying blocks of ideographic content. Justification is achieved by increasing or decreasing spacing between ideographic characters and words as well.
		inter-word	Justification is achieved by increasing the spacing between words. It is the quickest method of justification and does not justify the last line of a content block.
		newspaper	Spacing between letters and words are increased or decreased as necessary. The IE reference says “it is the most sophisticated form of justification for Latin alphabets.”	
		
		
		
		
		
		
		
		
		
		
		
		//CURSOR
		
		
		URL	A comma separated of URLs to custom cursors. Note: Always specify a generic cursor at the end of the list, in case none of the URL-defined cursors can be used
		auto	Default. The browser sets a cursor
		crosshair	The cursor render as a crosshair
		default	The default cursor
		e-resize	The cursor indicates that an edge of a box is to be moved right (east)
		help	The cursor indicates that help is available
		move	The cursor indicates something that should be moved
		n-resize	The cursor indicates that an edge of a box is to be moved up (north)
		ne-resize	The cursor indicates that an edge of a box is to be moved up and right (north/east)
		nw-resize	The cursor indicates that an edge of a box is to be moved up and left (north/west)
		pointer	The cursor render as a pointer
		progress	The cursor indicates that the program is busy (in progress)
		s-resize	The cursor indicates that an edge of a box is to be moved down (south)
		se-resize	The cursor indicates that an edge of a box is to be moved down and right (south/east)
		sw-resize	The cursor indicates that an edge of a box is to be moved down and left (south/west)
		text	The cursor indicates text
		w-resize	The cursor indicates that an edge of a box is to be moved left (west)
		wait	The cursor indicates that the program is busy
		inherit	Specifies that the value of the cursor property should be inherited from the parent element		
		
		*/
		
		
		
		private var _preferredWidth:Number = NaN;
		private var _preferredHeight:Number = NaN;
		
		private var _measuredWidth:Number = NaN;
		private var _measuredHeight:Number = NaN;
		
		private var _calculatedWidth:Number = NaN;
		private var _calculatedHeight:Number = NaN;
		
		private var _maxWidth:Number = NaN;
		private var _maxHeight:Number = NaN;
		
		private var _minWidth:Number = NaN;
		private var _minHeight:Number = NaN;	
		
		private var _percentWidth:Number = 100;
		private var _percentHeight:Number = 100;
		
		private var _margins:IMargin;
		private var _paddings:IPadding;
		private var _border:IBorder;
		
		/**
		* 	Creates a <code>Dimensions</code> instance.
		* 
		* 	@param left The left offset.
		* 	@param top The top offset.
		* 	@param width A width value.
		* 	@param height A height value.
		*/
		public function Dimensions(
			left:Number = 0,
			top:Number = 0,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( left, top, width, height );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get measuredWidth():Number
		{
			return _measuredWidth;
		}
		
		public function set measuredWidth( value:Number ):void
		{
			_measuredWidth = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get measuredHeight():Number
		{
			return _measuredHeight;
		}
		
		public function set measuredHeight( value:Number ):void
		{
			_measuredHeight = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasExplicitWidth():Boolean
		{
			return !isNaN( this.width ) && this.width > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasExplicitHeight():Boolean
		{
			return !isNaN( this.height ) && this.height > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isFlexibleWidth():Boolean
		{
			return !hasExplicitWidth();
		}

		/**
		* 	@inheritDoc
		*/
		public function isFlexibleHeight():Boolean
		{
			return !hasExplicitHeight();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		
		public function set maxWidth( value:Number ):void
		{
			_maxWidth = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get maxHeight():Number
		{
			return _maxHeight;
		}

		public function set maxHeight( value:Number ):void
		{
			_maxHeight = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get minWidth():Number
		{
			return _minWidth;
		}

		public function set minWidth( value:Number ):void
		{
			_minWidth = value;
		}

		/**
		* 	@inheritDoc
		*/
		public function get minHeight():Number
		{
			return _minHeight;
		}

		public function set minHeight( value:Number ):void
		{
			_minHeight = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		public function set percentWidth( value:Number ):void
		{
			_percentWidth = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		public function set percentHeight( value:Number ):void
		{
			_percentHeight = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPercentWidth():Boolean
		{
			return !isNaN( _percentWidth ) && _percentWidth > 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPercentHeight():Boolean
		{
			return !isNaN( _percentHeight ) && _percentHeight > 0;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get paddings():IPadding
		{
			if( _paddings == null )
			{
				_paddings = new Padding();
			}
			return _paddings;
		}
		
		public function set paddings( value:IPadding ):void
		{
			_paddings = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get margins():IMargin
		{
			if( _margins == null )
			{
				_margins = new Margin();
			}
			return _margins;
		}
		
		public function set margins( value:IMargin ):void
		{
			_margins = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get border():IBorder
		{
			if( _border == null )
			{
				_border = new Border();
			}
			return _border;
		}
		
		public function set border( border:IBorder ):void
		{
			_border = border;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get innerWidth():Number
		{
			if( !isNaN( preferredWidth ) )
			{
				return preferredWidth - paddings.width - border.width;
			}
			return measuredWidth;
		}
		
		/**
		*	@inheritDoc	s
		*/
		public function get innerHeight():Number
		{
			if( !isNaN( preferredHeight ) )
			{
				return preferredHeight - paddings.height - border.height;
			}
			return measuredHeight;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getPaddingRectangle():Rectangle
		{
			//TODO: change to calculated dimensions
			return new Rectangle(
				border.left,
				border.top,
				calculatedWidth - border.width,
				calculatedHeight - border.height );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBorderRectangle():Rectangle
		{
			return new Rectangle(
				0,
				0,
				calculatedWidth,
				calculatedHeight );
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function getRectangle():Rectangle
		{
			//TODO: change to calculated dimensions
			return new Rectangle( 0, 0, calculatedWidth, calculatedHeight );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getMarginRectangle():Rectangle
		{
			//TODO: change to calculated dimensions			
			return new Rectangle(
				-margins.left,
				-margins.top,
				calculatedWidth + margins.width,
				calculatedHeight + margins.height );
		}
		
		/**
		*	The preferred width specified the last
		* 	time the <code>calculate</code> method was invoked
		* 	or a value explicitly set as the component
		* 	calculated it's preferred dimensions.
		*/
		public function get preferredWidth():Number
		{
			if( hasExplicitWidth() )
			{
				return this.width;
			}
			return _preferredWidth;
		}
		
		public function set preferredWidth( value:Number ):void
		{
			_preferredWidth = value;
		}
		
		/**
		*	The preferred height specified the last
		* 	time the <code>calculate</code> method was invoked
		* 	or a value explicitly set as the component
		* 	calculated it's preferred dimensions.
		*/
		public function get preferredHeight():Number
		{
			if( hasExplicitHeight() )
			{
				return this.height;
			}
			return _preferredHeight;
		}
		
		public function set preferredHeight( value:Number ):void
		{
			_preferredHeight = value;
		}
		
		/**
		*	The width calculated the last
		* 	time the <code>calculate</code> method was invoked.
		* 
		* 	If the <code>calculate</code> method has not been
		* 	invoked this will return the preferred width.
		*/
		public function get calculatedWidth():Number
		{
			if( isNaN( _calculatedWidth ) )
			{
				return preferredWidth;
			}
			return _calculatedWidth;
		}
		
		/**
		*	The height calculated the last
		* 	time the <code>calculate</code> method was invoked.
		* 
		* 	If the <code>calculate</code> method has not been
		* 	invoked this will return the preferred height.
		*/
		public function get calculatedHeight():Number
		{
			if( isNaN( _calculatedHeight ) )
			{
				return preferredHeight;
			}
			return _calculatedHeight;
		}
				
		/**
		* 	@inheritDoc
		*/
		public function calculate(
			preferredWidth:Number,
			preferredHeight:Number ):IDimensions
		{
			var output:IDimensions = IDimensions( clone() );
			_preferredWidth = preferredWidth;
			_preferredHeight = preferredHeight;
			
			//TODO: clamp dimensions to min/max dimensions
			var cw:Number = _preferredWidth;
			var ch:Number = _preferredHeight;
			_calculatedWidth = cw;
			_calculatedHeight = ch;
			
			return output;
		}
		
		/**
		* 	Gets the class used to creates a clone of this
		* 	implementation.
		* 
		* 	@return The class of this implementation.
		*/
		public function getCloneClass():Class
		{
			return Dimensions;
		}
		
		/**
		* 	Gets an instance of the clone class.
		* 
		* 	@return A new instance of the clone class.
		*/
		public function getCloneInstance():Object
		{
			var clazz:Class = getCloneClass();
			return new clazz( left, top, width, height );
		}
		
		/**
		* 	Creates a clone of this implementation.
		* 
		* 	@return The cloned version of this implementation.
		*/
		override public function clone():Rectangle
		{
			var cloned:IDimensions = IDimensions( getCloneInstance() );
			cloned.minWidth = minWidth;
			cloned.minHeight = minHeight;
			cloned.maxWidth = maxWidth;
			cloned.maxHeight = maxHeight;
			cloned.percentWidth = percentWidth;
			cloned.percentHeight = percentHeight;
			if( paddings != null )
			{
				cloned.paddings = IPadding( paddings.clone() );
			}
			if( border != null )
			{
				cloned.border = IBorder( border.clone() );
			}
			if( margins != null )
			{
				cloned.margins = IMargin( margins.clone() );
			}
			return Rectangle( cloned );
		}
		
		/**
		* 	Destroy this implementation by cleaning 
		* 	composite references.
		*/
		public function destroy():void
		{
			_margins = null;
			_paddings = null;
			_border = null;
		}		
	}
}