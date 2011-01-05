package com.ffsys.ui.core
{

	public interface IComponentStyleCache
	{
		
		/**
		* 	Creates a copy of the current flat style cache object.
		* 
		* 	@return A copy of the cached style object.
		*/
		function copy():Object;
		
		/**
		* 	Updates this style cache with an array
		* 	of objects whose enumerable properties
		* 	will be copied into the main style cache
		* 	for the component.
		* 
		* 	@param styles The array of style objects.
		* 
		* 	@return The updated main style object.
		*/
		function update( styles:Array ):Object;
		
		/**
		* 	A flat representation of the style objects
		* 	located when this style cache was created.
		*/
		function get main():Object;
		function set main( value:Object ):void;		
		
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
	}

}

