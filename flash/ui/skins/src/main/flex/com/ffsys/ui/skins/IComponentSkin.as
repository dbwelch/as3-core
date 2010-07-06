package com.ffsys.ui.skins
{
	import com.ffsys.ui.states.IViewState;
	
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
		*	Adds a state using the identifier assigned to the state.
		*	
		*	This method will throw an exception if state
		*	is null or has a null identifier.
		*	
		*	@param state The state to add.
		*	
		*	@return Whether the state was added.
		*/
		function addState( state:IViewState ):Boolean;
		
		/**
		*	Gets a state by identifier.
		*	
		*	@param id The identifier for the state.
		*	
		*	@return The state or null if it could not be found.
		*/
		function getStateById( id:String ):IViewState;
		
		/**
		*	Adds a state by identifier.
		*	
		*	@param id The state identifier.
		*	@param state The state for the skin.
		*	
		*	The state will not be added if either
		*	the id or state parameters are null or if
		*	the state or id are already stored in this
		*	skin.
		*	
		*	@return Whether the state was added.	
		*/
		function addStateById(
			id:String, state:IViewState ):Boolean;
			
		/**
		*	Determines whether a state of the specified
		*	identifier exists in this skin.
		*	
		*	@param id The identifier for the state.
		*	
		*	@return Whether the state exists in this skin.
		*/
		function hasState( id:String ):Boolean;	
		
		
		/**
		* 	Removes a state by identifier.
		* 
		* 	@param id The identifier for the state.
		* 
		* 	@return Whether the state was removed or not.
		*/
		function removeStateById( id:String ):Boolean;
			
		/**
		*	The number of states in this skin.	
		*/
		function get length():uint;		
	}
}