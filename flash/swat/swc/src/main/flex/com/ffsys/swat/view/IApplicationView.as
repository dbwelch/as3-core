package com.ffsys.swat.view
{
	import flash.text.Font;
	import flash.text.TextField;
	
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
		
		/**
		* 	Registers a font from a class path and returns
		* 	an instance of the font.
		* 
		* 	@param classPath The fully qualified class path to the font.
		* 
		* 	@return An instance of the font.
		*/
		function registerFont( classPath:String ):Font;
		
		/**
		* 	Creates a text field.
		*/
		function createTextField(
			text:String = "",
			width:Number = 140,
			height:Number = 80,
			font:String = null,
			size:Number = 12,
			color:Number = 0xffffff ):TextField;
	
		/**
		* 	Applies a set of properties to an object
		*	only if the <code>target</code> has the corresponding property
		*	extracted from the source <code>properties</code> object.
		*	
		*	@param target The target to have the properties set.
		*	@param properties The properties to set on the target.
		*/
		function applyProperties(
			target:Object, properties:Object ):void;
	
		/**
		* 	Applies source properties to a text field.
		*	
		*	@param txt The target text field.
		*	@param properties The properties to set.
		*/
		function applyTextFieldProperties(
			txt:TextField, properties:Object ):void;
	
		/**
		* 	Applies text format properties to a text field.
		*	
		*	This operates on the <code>defaultTextFormat</code>
		*	associated with the text field.
		*	
		*	@param txt The text field to format.
		*	@param properties The properties to set on the text format.
		*/
		function applyTextFormatProperties(
			txt:TextField, properties:Object ):void;	
	}
}