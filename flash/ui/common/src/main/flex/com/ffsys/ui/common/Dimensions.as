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
	*	@since  19.06.2010
	*/
	public class Dimensions extends Rectangle
		implements IDimensions
	{
		private var _maximumWidth:Number;
		private var _maximumHeight:Number;
		
		private var _minimumWidth:Number;
		private var _minimumHeight:Number;
		
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
			width:Number = 0,
			height:Number = 0 )
		{
			super( left, top, width, height );
		}
		
		/**
		* 	A maximum width for this implementation.
		*/
		public function get maximumWidth():Number
		{
			return _maximumWidth;
		}
		
		public function set maximumWidth( value:Number ):void
		{
			_maximumWidth = value;
		}
		
		/**
		* 	A maximum height for this implementation.
		*/
		public function get maximumHeight():Number
		{
			return _maximumHeight;
		}

		public function set maximumHeight( value:Number ):void
		{
			_maximumHeight = value;
		}
		
		/**
		* 	A minimum width for this implementation.
		*/
		public function get minimumWidth():Number
		{
			return _minimumWidth;
		}

		public function set minimumWidth( value:Number ):void
		{
			_minimumWidth = value;
		}

		/**
		* 	A minimum height for this implementation.
		*/
		public function get minimumHeight():Number
		{
			return _minimumHeight;
		}

		public function set minimumHeight( value:Number ):void
		{
			_minimumHeight = value;
		}				
		
		public function setPercentDimensions(
			parent:IDimensions,
			width:Number,
			height:Number ):void
		{
			//TODO
		}
	}
}