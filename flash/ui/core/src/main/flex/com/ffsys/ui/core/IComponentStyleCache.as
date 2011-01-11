package com.ffsys.ui.core
{
	
	import com.ffsys.core.IClone;
	import com.ffsys.ui.css.*;

	public interface IComponentStyleCache extends IClone
	{
		/**
		* 	Applies the styles associated with this
		* 	style cache to the target component.
		* 
		* 	@return A list of the applied style objects.
		*/
		function apply( target:IComponent ):Array;
		
		/**
		* 	Creates a copy of the current flat style cache object.
		* 
		* 	@return A copy of the cached style object.
		*/
		function copy():CssStyle;
		
		function propagate( component:IComponent ):void;
		
		function inherit( parent:IComponentStyleCache ):void;
		
		/**
		* 	Updates this style cache with an array
		* 	of objects whose enumerable properties
		* 	will be copied into the source style cache
		* 	for the component.
		* 
		* 	@param styles The array of style objects.
		* 
		* 	@return The updated source style object.
		*/
		function update( styles:Array ):Object;
		
		/**
		* 	A flat representation of the style objects
		* 	located when this style cache was created.
		*/
		function get source():CssStyle;
		function set source( value:CssStyle ):void;		
		
		/**
		* 	The list of style names that applied to the component
		* 	when this style cache was created.
		*/
		function get styleNames():Array;
		function set styleNames( value:Array ):void;
		
		/**
		* 	The list of style objects that each style name references.
		*/		
		function get styleObjects():Array;
		function set styleObjects( value:Array ):void;
		
		/**
		* 	The custom styles assigned to the component
		* 	when this style cache was created.
		* 
		* 	This will not include the class level style identifier
		* 	or any <code>id</code> based style name.
		*/
		function get styles():String;
		function set styles( value:String ):void;
		
		/**
		* 	Creates a clone of this style cache
		* 	in it's current state.
		* 
		* 	@return A clone of this style cache.
		*/
		function clone():IComponentStyleCache;
	}
}