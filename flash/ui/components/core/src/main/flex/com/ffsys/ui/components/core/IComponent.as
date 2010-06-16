package com.ffsys.ui.components.core
{
	import flash.display.DisplayObject;
	
	import com.ffsys.core.IBitmapGrab;
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	
	import com.ffsys.ui.text.TextFieldFactory;
	
	/**
	*	Describes the contract for all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponent
		extends IBitmapGrab,
				IEnabled,
				IDestroy
	{
		
		/**
		* 	The text field factory used to create textfields.
		*/
		function get textFieldFactory():TextFieldFactory;
		
		/**
		* 	Gets a runtime asset by fully qualified class path.
		* 
		* 	The class referenced must have a no argument constructor.
		* 
		* 	@param classPath The fully qualified class path to the runtime
		* 	asset.
		* 
		* 	@return An instance of the class referenced by class path.
		*/
		function getRuntimeAsset( classPath:String ):Object;
		
		/**
		* 	Gets a runtime object as a display object.
		* 
		* 	@param classPath The fully qualified class path to the runtime
		* 	asset.
		* 
		* 	@return An instance of the class referenced by class path as a
		* 	display object.
		*/
		function getRuntimeDisplayObject( classPath:String ):DisplayObject;
	}
}