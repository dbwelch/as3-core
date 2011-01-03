package com.ffsys.ui.css {
	
	import flash.filters.BitmapFilter;
	import flash.text.StyleSheet;	
	import flash.text.TextFormat;
	
	import com.ffsys.ioc.*;	
	
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
		extends	IBeanDocument,
		 		IStyleAccess {
			
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