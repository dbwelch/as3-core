package com.ffsys.swat.view
{
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.Settings;
	
	/**
	*	Describes the contract for application views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IApplicationView extends IConfigurationAware
	{
		/**
		* 	Creates child display list objects.
		* 
		* 	The default implementation of this method
		* 	does nothing. Concrete sub-classes should
		* 	override and implement this method.
		*/
		function createChildren():void;
		
		/**
		*	Gets whether this view is enabled.
		*	
		*	@return Whether this view is enabled.	
		*/
		function get enabled():Boolean;
		
		/**
		*	Sets whether this view is enabled.
		*	
		*	@param enabled Determines whether this view is enabled.
		*/
		function set enabled( enabled:Boolean ):void;
		
		/**
		* 	Removes all child display list objects.
		*/
		function removeAllChildren():void;
		
		/**
		* 	Gets the application asset manager.
		* 
		* 	@return The application asset manager.
		*/
		function get assetManager():AssetManager;
		
		/**
		* 	Gets the application settings.
		*
		*	@return The application settings.
		*/
		function get settings():Settings;
	}
}