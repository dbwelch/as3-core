package com.ffsys.ui.skins
{
	import com.ffsys.ui.states.ISkinStates;
	
	/**
	*	Represents a component skin.
	* 
	* 	This class encapsulates the skin states and
	* 	provides access to the current state.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ComponentSkin extends Object
		implements IComponentSkin
	{
		private var _states:ISkinStates;
		
		/**
		* 	Creates a <code>ComponentSkin</code> instance.
		*/
		public function ComponentSkin()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get states():ISkinStates
		{
			return _states;
		}
		
		public function set states( states:ISkinStates ):void
		{
			_states = states;
		}
	}
}