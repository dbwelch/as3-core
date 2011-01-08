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