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
		* 	A measured width that represents a width
		* 	calculated by measuring some display content
		* 	such as child display objects.
		* 
		* 	The default behaviour is that this is equivalent
		* 	to the <code>width</code> property of the component.
		*/
		function get measuredWidth():Number;
		function set measuredWidth( value:Number ):void;
		
		/**
		* 	A measured height that represents a height
		* 	calculated by measuring some display content
		* 	such as child display objects.
		* 
		* 	The default behaviour is that this is equivalent
		* 	to the <code>height</code> property of the component.
		*/
		function get measuredHeight():Number;
		function set measuredHeight( value:Number ):void;		
		
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
		*	The preferred width for these dimensions
		* 	taking into account paddings and border sizes.
		* 
		* 	If no preferred width has been set this will
		* 	return the measured width.
		*/
		function get innerWidth():Number;
		
		/**
		*	The preferred height for these dimensions
		* 	taking into account paddings and border sizes.
		* 
		* 	If no preferred height has been set this will
		* 	return the measured height.
		*/
		function get innerHeight():Number;
			
		/**
		*	The preferred width specified the last
		* 	time the <code>calculate</code> method was invoked
		* 	or a value explicitly set as the component
		* 	calculates it's preferred dimensions.
		*/
		function get preferredWidth():Number;
		function set preferredWidth( value:Number ):void;
		
		/**
		*	The preferred height specified the last
		* 	time the <code>calculate</code> method was invoked
		* 	or a value explicitly set as the component
		* 	calculates it's preferred dimensions.
		*/
		function get preferredHeight():Number;
		function set preferredHeight( value:Number ):void;
		
		/**
		* 	Creates a clone of these dimensions.
		* 
		* 	@return The cloned version of these dimensions.
		*/
		function clone():Rectangle;
	}
}