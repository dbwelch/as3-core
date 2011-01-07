package com.ffsys.ui.common
{
	import flash.geom.Rectangle;
	
	/**
	*	Represents the dimensions of a component.
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
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		
		private var _minWidth:Number;
		private var _minHeight:Number;	
		
		private var _percentWidth:Number;
		private var _percentHeight:Number;
		
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
		public function isFlexibleWidth():Boolean
		{
			return isNaN( this.width );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isFlexibleHeight():Boolean
		{
			return isNaN( this.height );
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
		public function getRenderDimensions(
			calculatedWidth:Number,
			calculatedHeight:Number,
			parentPercentWidth:IDimensions,
			parentPercentHeight:IDimensions ):void
		{
			//TODO
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
			return Rectangle( cloned );
		}
	}
}