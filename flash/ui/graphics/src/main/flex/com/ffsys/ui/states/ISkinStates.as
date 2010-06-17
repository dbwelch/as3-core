package com.ffsys.ui.states
{
	/**
	*	Describes the contract for instances that
	* 	encapsulate multiple states.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface ISkinStates
	{
		/**
		*	The main state for the component. 
		*/
		function get main():IViewState;
		function set main( state:IViewState ):void;
		
		/**
		*	The disabled state for the component.
		*/
		function get disabled():IViewState;
		function set disabled( state:IViewState ):void;
		
		/**
		*	The down state for the component.
		* 
		* 	This state is rendered when the mouse is pressed
		* 	on the component.
		*/
		function get down():IViewState;
		function set down( state:IViewState ):void;
		
		/**
		*	The over state for the component.
		* 
		* 	This state is rendered when the mouse is over
		* 	the component.
		*/
		function get over():IViewState;
		function set over( state:IViewState ):void;		
	}
}