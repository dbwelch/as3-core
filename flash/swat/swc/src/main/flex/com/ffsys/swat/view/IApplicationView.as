package com.ffsys.swat.view
{
	import flash.text.Font;
	import flash.text.TextField;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.Settings;
	
	import com.ffsys.swat.configuration.IMessageAccess;
	import com.ffsys.swat.configuration.IMediaAccess;
	
	import com.ffsys.ui.css.IStyleAware;
	
	/**
	*	Describes the contract for application views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IApplicationView
		extends IEnabled,
				IDestroy,
				IMessageAccess,
				IMediaAccess,
				IStyleAware
	{
		
		/**
		*	Gets the utility configuration properties
		*	and functionality exposed to all views.
		*/
		function get utils():IViewUtils;
		
		/**
		* 	Gets the application flash variables.
		*	
		*	@return The application flash variables.
		*/
		function get flashvars():IFlashVariables;		
		
		/**
		* 	Creates child display list objects.
		* 
		* 	The default implementation of this method
		* 	does nothing. Concrete sub-classes should
		* 	override and implement this method.
		*/
		function createChildren():void;
		
		/**
		* 	Removes all child display list objects.
		*/
		function removeAllChildren():void;
	}
}