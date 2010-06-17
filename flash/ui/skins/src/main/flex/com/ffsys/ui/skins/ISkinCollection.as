package com.ffsys.ui.skins
{
	import com.ffsys.ui.core.IComponent;
	
	/**
	* 	Describes the contract for collections of skins.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface ISkinCollection
	{
		/**
		* 	Adds a component skin by component class.
		* 
		* 	@param clazz The component class.
		* 	@param skin The component skin.
		*/
		function addComponentClassSkin(
			clazz:Class, skin:IComponentSkin ):void;
			
		/**
		* 	Adds a component skin by component.
		* 
		* 	This method uses the component identifer
		* 	to store and extract component skins so the
		* 	passed component must have a valid identifier.
		* 
		* 	@param component The component instance.
		* 	@param skin The component skin.
		*/
		function addComponentSkin(
			component:IComponent, skin:IComponentSkin ):void;
			
		/**
		* 	Adds a component skin by component.
		* 
		* 	This method uses the component identifer
		* 	to store and extract component skins so the
		* 	passed component must have a valid identifier.
		* 
		* 	@param component The component instance.
		* 	@param skin The component skin.
		*/
		function getComponentSkin(
			component:IComponent ):IComponentSkin;
			
		/**
		* 	Retrieves the class of a component.
		* 
		* 	@param component The component instance.
		* 
		* 	@return The class of the component.
		*/
		function getComponentClass(
			component:IComponent ):Class;
	}
}