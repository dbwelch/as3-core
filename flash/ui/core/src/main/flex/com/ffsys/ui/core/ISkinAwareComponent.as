package com.ffsys.ui.core
{
	import com.ffsys.ui.skins.IComponentSkin;
	
	/**
	*	Describes the contract for components that can be skinned.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface ISkinAwareComponent extends IComponent
	{
		/**
		* 	The skin associated with this component.
		*/
		function get skin():IComponentSkin;
		function set skin( skin:IComponentSkin ):void;
	}
}