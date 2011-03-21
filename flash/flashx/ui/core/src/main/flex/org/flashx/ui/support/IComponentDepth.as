package org.flashx.ui.support
{
	import org.flashx.core.IDestroy;
	
	import org.flashx.ui.core.*;
	
	/**
	*	Decribes the contract for implementations that
	* 	provide support for manipulating the depth of components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public interface IComponentDepth extends IDestroy
	{
		/**
		* 	The component whose depth is being managed.
		*/
		function get component():IComponent;
		function set component( value:IComponent ):void;
		
		/**
		* 	Attempts to change the depth of the target
		* 	component up.
		* 
		* 	@param amount The amount of depth increments
		* 	to attempt to move the component.
		* 
		* 	@return A boolean indicating whether the depth changed.
		*/
		function up( amount:uint = 1 ):Boolean;
		
		/**
		* 	Attempts to change the depth of the target
		* 	component down.
		* 
		* 	@param amount The amount of depth increments
		* 	to attempt to move the component.
		* 
		* 	@return A boolean indicating whether the depth changed.
		*/
		function down( amount:uint = 1 ):Boolean;
		
		/**
		* 	The current depth of this component.
		*/
		function get current():int;
		function set current( value:int ):void;
	}
}