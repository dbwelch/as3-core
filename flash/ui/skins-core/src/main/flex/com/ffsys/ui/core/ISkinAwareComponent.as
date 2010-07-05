package com.ffsys.ui.core
{
	import com.ffsys.ui.skins.IComponentSkin;
	import com.ffsys.ui.skins.ISkinCollection;
	
	/**
	*	Describes the contract for components that can be skinned.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface ISkinAwareComponent extends IInteractiveComponent
	{
		/**
		* 	The skin associated with this component.
		*/
		function get skin():IComponentSkin;
		function set skin( skin:IComponentSkin ):void;
		
		/**
		* 	A reference to the collection of skins.
		*/
		function get skins():ISkinCollection;
	}
}