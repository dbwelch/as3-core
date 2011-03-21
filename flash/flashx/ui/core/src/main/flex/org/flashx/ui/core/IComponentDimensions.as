package org.flashx.ui.core
{
	import org.flashx.ui.common.*;

	/**
	*	Describes the contract for implementations that
	* 	represent the dimensions of a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public interface IComponentDimensions
		extends IDimensions
	{
		/**
		* 	Measures the dimensions of a component.
		* 
		* 	@param preferredWidth The preferred width for the component.
		* 	@param preferredHeight The preferred height for the component.
		* 	@param component The component being measured.
		* 
		* 	@return This component dimensions updated to reflect
		* 	the measurement changes.
		*/
		function measure(
			preferredWidth:Number,
			preferredHeight:Number,
			component:IComponent ):IComponentDimensions;
	}
}