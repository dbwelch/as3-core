package com.ffsys.swat.view
{
	import flash.text.Font;
	import flash.text.TextField;
	
	import com.ffsys.core.IEnabled;
	import com.ffsys.ui.text.ITextFieldFactory;
	import com.ffsys.ui.text.TextFieldFactory;
	import com.ffsys.swat.configuration.AssetManager;
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
	public interface IApplicationView
		extends IEnabled
	{
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