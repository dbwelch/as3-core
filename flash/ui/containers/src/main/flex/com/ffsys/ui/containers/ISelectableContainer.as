package com.ffsys.ui.containers
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.common.ISelectedIndex;
	import com.ffsys.ui.common.ISelectedDisplayObject;
	
	/**
	*	Describes the contract for containers that allow
	* 	child display objects to be selected.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public interface ISelectableContainer
		extends IContainer,
				ISelectedIndex,
				ISelectedDisplayObject
	{
		//
	}
}
