package com.ffsys.swat.view
{
	import flash.text.Font;
	import flash.text.TextField;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.Settings;
	
	import com.ffsys.utils.css.IStyleAware;
	import com.ffsys.utils.css.IStyleStrategy;
	
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
				IStyleAware
	{
		/**
		*	The strategy used to apply styles.
		*/
		function get strategy():IStyleStrategy;
		function set strategy( strategy:IStyleStrategy ):void;
		
		/**
		*	Gets the utility configuration properties
		*	and functionality exposed to all views.
		*/
		function get utils():IViewUtils;
		
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