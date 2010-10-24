package com.ffsys.ui.css {
	
	import flash.events.IEventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.text.TextFormat;
	
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Describes the contract for collections
	*	of css style.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface ICssStyleCollection
		extends	IStringIdentifier,
				IEventDispatcher {
		
		/**
		*	A queue that represents the dependencies that
		*	were found when the css was parsed.
		*/
		function get dependencies():ILoaderQueue;
		
		/**
		*	Parses the css text into this instance
		*	and returns a loader queue implementation
		*	responsible for loading any external dependencies
		*	declared in the css.
		*	
		*	@param text The css text to parse.
		*	
		*	@return The loader queue responsible for loading
		*	external dependencies.
		*/
		function parse( text:String ):ILoaderQueue;
		
		/**
		*	Extends the native style sheet parsing capability.
		*	
		*	@param text The css text to parse.
		*/
		function parseCSS( text:String ):void;
		
		/**
		*	Extends the native text format transform ability.	
		*	
		*	@param style The style object to transform to a text format.
		*	
		*	@return The transformed text format.
		*/
		function transform( style:Object ):TextFormat;
		
		/**
		*	The array of style names loaded into this style
		*	collection.
		*	
		*	Note that the order of the array elements is not
		*	guaranteed as the underlying syle sheet data is
		*	queried when this method is called.
		*	
		*	@return An array of string style names.
		*/
		function get styleNames():Array;
		
		/**
		*	Returns a copy of the style object associated
		*	with the style named styleName.
		*	
		*	@param styleName A string that specifies the name
		*	of the style to retrieve.
		*/
		function getStyle( styleName:String ):Object;
		
		/**
		*	Adds a new style with the specified name to the
		*	style sheet object. If the named style does not
		*	already exist in the style sheet, it is added.
		*	If the named style already exists in the style sheet,
		*	it is replaced. If the styleObject parameter is null,
		*	the named style is removed.
		*
		*	Flash Player creates a copy of the style object that
		*	you pass to this method.
		*
		*	For a list of supported styles, see the table in the
		*	description for the StyleSheet class.
		*	
		*	@param styleName A string that specifies the name of the style
		*	to add to the style sheet.
		*	@param styleObject An object that describes the style, or null.
		*/
		function setStyle( styleName:String, styleObject:Object ):void;
		
		/**
		*	Removes all styles from this style collection.	
		*/
		function clear():void;
		
		/**
		*	Attempts to retrieve a style as a bitmap filter.
		*	
		*	The style must have a filter-class declaration
		*	that indicates the type of filter to instantiate.
		*/
		function getFilter( styleName:String ):BitmapFilter;		
	}
}