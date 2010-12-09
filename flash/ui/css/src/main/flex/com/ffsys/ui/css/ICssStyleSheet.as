package com.ffsys.ui.css {
	
	import flash.events.IEventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.text.TextFormat;
	
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.utils.substitution.IBindingCollection;
	
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
	public interface ICssStyleSheet
		extends	IStringIdentifier,
				IEventDispatcher {
					
		/**
		* 	Gets the style object that encapsulates constants for the stylesheet.
		*/
		function get constants():Object;
					
		/**
		* 	The collection of bindings to expose when parsing css files.
		*/
		function get bindings():IBindingCollection;
		function set bindings( bindings:IBindingCollection ):void;			
										
		/**
		* 	The delimiter to use when parsing array values.
		* 
		* 	The default value is a vertical bar.
		*/
		function get delimiter():String;
		function set delimiter( value:String ):void;					
		
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
		* 	Parses an individual string value.
		* 
		* 	@param value The value to parse.
		* 	@param styleName The name of the style the property belongs to.
		* 	@param propertyName The name of the property the value was extracted from.
		* 
		* 	@return The parsed value.
		*/
		function parseElement( value:String, styleName:String, propertyName:String ):Object;
		
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
		* 	Attempts to retrieve an instance of a style that defines 
		* 	an <code>instance-class</code> class reference.
		* 	
		* 	@param styleName The style name.
		* 	@param style The style object that the instance will be instantiated
		* 	from.
		*/
		function getInstance( styleName:String, style:Object ):Object;
		
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
		* 	Gets an array of all the style names for a style aware target.
		* 
		* 	This method includes any identifier style and class level style names as well
		* 	as any styles associated with the target using the <code>styles</code> property.
		* 
		* 	@param target The style aware target.
		* 	@param custom Any custom styles you want to apply in addition to the styles
		* 	retrieved from the target.
		* 
		* 	@return An array containing the style names that represents all the styles that should
		* 	be applied to the target.
		*/
		function getStyleNameList( target:IStyleAware, ... custom ):Array;
		
		/**
		* 	Gets a string representing all the styles that should be applied to a target.
		* 
		* 	@param target The style aware target.
		* 	@param custom Any custom styles you want to apply in addition to the styles
		* 	retrieved from the target.
		* 
		* 	@return A string representing the style names that would be applied to the style
		* 	aware target.
		*/
		function getStyleNames( target:IStyleAware, ... custom ):String;
		
		/**
		* 	Gets the style objects for all the valid styles that the target is aware of.
		* 
		* 	@param target The style aware target.
		* 	@param custom Any custom styles you want to apply in addition to the styles
		* 	retrieved from the target.
		* 
		* 	@return An array containing the styles that would be applied to the style
		* 	aware target.
		*/
		function getStyleObjects( target:IStyleAware, ... custom ):Array;
		
		/**
		*	Retrieves an array of all the style objects matched by the specified
		*	style name.
		*	
		*	If the style name does not contain any spaces then we are expected
		*	to be searching for a single style. If any spaces are found in the
		*	style name then the style name string is split on a space character
		*	and we attempt to locate a style for each part of the style name
		*	parameter.
		*	
		*	@param styleName The name of the style.
		*	
		*	@return An array of the styles that were found.
		*/
		function getStyles( styleName:String ):Array;
		
		/**
		*	Applies a style to a target object.
		*	
		*	@param target The target object to apply the style to.
		*	@param styleName The name of the style to apply.
		*	
		*	@return An array of the style objects that were applied or an empty
		*	array if no styles were applied.
		*/
		function apply(
			target:Object,
			styleName:String ):Array;
			
		/**
		*	Applies styles a style aware target.
		*	
		*	This extends the behaviour of <code>apply</code> to also
		*	search for style objects by class name and identifier.
		*	
		*	@param target The target to style.
		* 	@param ...custom Custom style objects to apply in addition
		* 	to any styles found on the style aware instance.
		*/
		function style( target:IStyleAware, ...custom ):void;
		
		/**
		*	Attempts to retrieve a style as a bitmap filter.
		*	
		*	The style must have a filter-class declaration
		*	that indicates the type of filter to instantiate.
		*/
		function getFilter( styleName:String ):BitmapFilter;		
	}
}