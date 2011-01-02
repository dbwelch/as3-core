package com.ffsys.ui.core
{
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IStringIdentifier;
		
	import com.ffsys.ui.common.ISelectedIndex;
	import com.ffsys.ui.common.ISelectedDisplayObject;
	import com.ffsys.ui.core.IComponent;		

	/**
	*	Describes the contract for components that manage
	* 	a group of components but are not themselves component
	* 	implementations that can be added to the display list.
	* 
	* 	These implementations are considered to be abstract (non-visual)
	* 	and exist solely to manage a group of other components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public interface IComponentGroupManager
		extends ISelectedIndex,
				ISelectedDisplayObject,
				IStringIdentifier,
				IEventDispatcher
	{
		/**
		* 	The components being managed by this group manager.
		*/
		function get components():Vector.<IComponent>;
		
		/**
		* 	Determines whether this implementation is managing
		* 	the specified component.
		* 
		* 	@param component The component to test for existence.
		* 
		* 	@return A boolean indicating whether the component is being
		* 	managed by this implementation.
		*/
		function hasComponent( component:IComponent ):Boolean;
		
		/**
		* 	Adds a component to this manager.
		* 
		* 	@param component The component to add.
		* 
		* 	@return A boolean indicating whether the component was added.
		*/
		function addComponent( component:IComponent ):Boolean;
		
		/**
		* 	Removes a component to this manager.
		* 
		* 	@param component The component to remove.
		* 
		* 	@return A boolean indicating whether the component was removed.
		*/
		function removeComponent( component:IComponent ):Boolean;
		
		/**
		* 	The number of components being managed.
		*/
		function get length():uint;
	}
}