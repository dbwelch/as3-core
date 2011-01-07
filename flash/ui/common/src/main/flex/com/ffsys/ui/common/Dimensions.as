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
		
		private var _calculatedWidth:Number = NaN;
		private var _calculatedHeight:Number = NaN;
		
		private var _maxWidth:Number = NaN;
		private var _maxHeight:Number = NaN;
		
		private var _minWidth:Number = NaN;
		private var _minHeight:Number = NaN;	
		
		private var _percentWidth:Number = NaN;
		private var _percentHeight:Number = NaN;
		
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
		public function hasExplicitWidth():Boolean
		{
			return !isNaN( this.width );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasExplicitHeight():Boolean
		{
			return !isNaN( this.height );
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
			return !isNaN( _percentWidth );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPercentHeight():Boolean
		{
			return !isNaN( _percentHeight );
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
		public function getPaddingRectangle():Rectangle
		{
			//TODO: change to calculated dimensions
			return new Rectangle(
				0,
				0,
				_preferredWidth,
				_preferredHeight );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getRectangle():Rectangle
		{
			//TODO: change to calculated dimensions
			return new Rectangle( 0, 0, _preferredWidth, _preferredHeight );
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
				_preferredWidth + margins.width,
				_preferredHeight + margins.height );
		}			
		
		/**
		*	The preferred width specified the last
		* 	time the <code>calculate</code> method was invoked.
		*/
		public function get preferredWidth():Number
		{
			return _preferredWidth;
		}
		
		/**
		*	The preferred height specified the last
		* 	time the <code>calculate</code> method was invoked.
		*/
		public function get preferredHeight():Number
		{
			return _preferredHeight;
		}
		
		/**
		*	The width calculated the last
		* 	time the <code>calculate</code> method was invoked.
		*/
		public function get calculatedWidth():Number
		{
			return _calculatedWidth;
		}
		
		/**
		*	The height calculated the last
		* 	time the <code>calculate</code> method was invoked.
		*/
		public function get calculatedHeight():Number
		{
			return _calculatedHeight;
		}
				
		/**
		* 	@inheritDoc
		*/
		public function calculate(
			preferredWidth:Number,
			preferredHeight:Number ):IDimensions
		{
			_preferredWidth = preferredWidth;
			_preferredHeight = preferredHeight;
			
			//TODO: clamp dimensions to min/max dimensions
			var cw:Number = _preferredWidth;
			var ch:Number = _preferredHeight;
			_calculatedWidth = cw;
			_calculatedHeight = ch;
			
			return this;
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