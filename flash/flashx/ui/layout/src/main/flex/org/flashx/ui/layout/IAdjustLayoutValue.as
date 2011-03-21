package org.flashx.ui.layout
{
	
	import flash.display.*;

	public interface IAdjustLayoutValue
	{
		
		/**
		*	Allows display objects that are taking
		* 	part in a layout to adjust the layout
		* 	value.
		* 
		* 	@param layout The layout handling positioning the display object.
		* 	@param value The value calculated by the layout.
		* 	@param parent The parent display object container.
		* 	@param child The current display object taking part in the layout.
		* 	@param pevious A previous sibling display object if available.
		*/
		function adjustLayoutValue(
			layout:ILayout,
			value:Object,
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):Object;
	}
}