package com.ffsys.ui.css {
	
	import flash.filters.BitmapFilter;
	import flash.text.StyleSheet;	
	import flash.text.TextFormat;
	
	import com.ffsys.ioc.*;	
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.ui.common.IStyleAware;		
	
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
		extends	IBeanDocument,
		 		IStyleAccess {
			
		/**
		* 	Gets a flattened representation of a multiple
		* 	style objects.
		* 
		* 	Style objects are merged in the order they are
		* 	declared so the last style wins.
		* 
		* 	@param styles An array of style objects.
		* 
		* 	@return A flat representation of all the style object
		* 	properties.
		*/
		function getFlatStyle( styles:Array ):CssStyle;
			
		/**
		* 	Gets a style name list and a list with the corresponding
		* 	style object for each style name.
		* 
		* 	@param target The style aware target.
		* 	@param custom Any additional styles to handle.
		* 
		* 	@return An array with two elements, the first is an array
		* 	of the style names while the second elements is the array
		* 	of style objects.
		*/
		function getStyleInformation( target:IStyleAware, ... custom ):Array;
			
		/**
		* 	Gets a <code>StyleSheet</code> representation
		* 	of this css style sheet.
		* 
		* 	Note this implementation creates a <code>StyleSheet</code> instance
		* 	each time it is invoked so should be invoked with care.
		* 
		* 	@return The created <code>StyleSheet</code>.
		*/
		function toStyleSheet():StyleSheet;
		
		/**
		*	Applies a collection of style objects to a target.
		* 
		* 	@param target The target object receiving the style properties.
		* 	@param styles The list of style objects.
		*/
		function applyStyles( target:Object, styles:Array ):void;

		/**
		*	Applies a style object to a target.
		* 
		* 	@param target The target object receiving the style properties.
		* 	@param style The style object.
		*/
		function applyStyle( target:Object, style:Object ):void;
	}
}