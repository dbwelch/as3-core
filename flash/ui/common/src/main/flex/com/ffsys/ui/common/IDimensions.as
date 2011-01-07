package com.ffsys.ui.common
{
	import flash.geom.Rectangle;
	
	import com.ffsys.core.IClone;
	import com.ffsys.core.IDestroy;
	
	/**
	*	Describes the contract for implementations
	* 	that represent a set of dimensions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public interface IDimensions
		extends IBorderAware,
				IPaddingAware,
				IMarginAware,
				IDestroy,
				IClone
	{
		/**
		* 	Determines whether this implementation has an explicitly
		* 	set width.
		* 
		* 	@return A boolean indicating whether the width
		* 	of this implementation has been explicitly set.
		*/
		function hasExplicitWidth():Boolean;
		
		/**
		* 	Determines whether this implementation has an explicitly
		* 	set height.
		* 
		* 	@return A boolean indicating whether the height
		* 	of this implementation has been explicitly set.
		*/
		function hasExplicitHeight():Boolean;
		
		/**
		* 	Determines whether the width is considered
		* 	to be flexibile.
		* 
		* 	The width of a component is considered to be flexibile
		* 	when no width has been explicitly set.
		* 
		* 	@return A boolean indicating whether the width is flexible.
		*/
		function isFlexibleWidth():Boolean;
		
		/**
		* 	Determines whether the height is considered
		* 	to be flexibile.
		* 
		* 	The height of a component is considered to be flexibile
		* 	when no height has been explicitly set.
		* 
		* 	@return A boolean indicating whether the height is flexible.
		*/
		function isFlexibleHeight():Boolean;
		
		/**
		* 	Determines whether a percentage width value
		* 	has been specified.
		* 
		* 	@return Whether a percentage width has been specified.
		*/
		function hasPercentWidth():Boolean;
		
		/**
		* 	Determines whether a percentage height value
		* 	has been specified.
		* 
		* 	@return Whether a percentage height has been specified.
		*/
		function hasPercentHeight():Boolean;
		
		/**
		* 	A maximum width for these dimensions.
		*/
		function get maxWidth():Number;
		function set maxWidth( value:Number ):void;
		
		/**
		* 	A maximum height for these dimensions.
		*/
		function get maxHeight():Number;
		function set maxHeight( value:Number ):void;
		
		/**
		* 	A minimum width for these dimensions.
		*/
		function get minWidth():Number;
		function set minWidth( value:Number ):void;
		
		/**
		* 	A minimum height for these dimensions.
		*/
		function get minHeight():Number;
		function set minHeight( value:Number ):void;
		
		/**
		* 	A percentage width for these dimensions.
		*/
		function get percentWidth():Number;
		function set percentWidth( value:Number ):void;
		
		/**
		* 	A percentage height for these dimensions.
		*/
		function get percentHeight():Number;
		function set percentHeight( value:Number ):void;
		
		
		/**
		*	Gets a rectangle that represents the inner
		*	area inside any padding settings.	
		*/
		function getPaddingRectangle():Rectangle;
		
		/**
		*	Gets a rectangle that represents the dimensions
		*	of this component.
		*/
		function getRectangle():Rectangle;
		
		/**
		*	Gets a rectangle that represents the outer
		*	area outside any margin settings.
		*/
		function getMarginRectangle():Rectangle;
		
		/**
		* 	Calculates the width and height
		* 	based on a specified preferred width
		* 	and height.
		* 
		* 	@param preferredWidth The preferred width.
		* 	@param preferredHeight The preferred height.
		* 
		* 	@return The dimensions updated with the calculated
		* 	values.
		*/
		function calculate(
			preferredWidth:Number,
			preferredHeight:Number ):IDimensions;		
		
		/**
		* 	Creates a clone of these dimensions.
		* 
		* 	@return The cloned version of these dimensions.
		*/
		function clone():Rectangle;
	}
}