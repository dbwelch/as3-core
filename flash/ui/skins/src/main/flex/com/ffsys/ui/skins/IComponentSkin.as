package com.ffsys.ui.skins
{
	import com.ffsys.ui.states.ISkinStates;
	
	/**
	*	Describes the contract for instances that
	* 	represent a component skin.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface IComponentSkin
	{
		/**
		* 	The set of states for the skin.
		*/
		function get states():ISkinStates;
		function set states( states:ISkinStates ):void;		
	}
}