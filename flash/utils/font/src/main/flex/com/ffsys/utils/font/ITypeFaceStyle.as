package com.ffsys.utils.font {
	
	import flash.text.StyleSheet;
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for instances
	*	that represent an individual style associated
	*	with a type face.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2008
	*/
	public interface ITypeFaceStyle
		extends IStringIdentifier {
		
		/**
		*	Arbitrary css associated with this style.	
		*/
		function set css( val:String ):void;
		function get css():String;	
		
		/**
		*	Gets the style sheet created when
		*	the <code>css</code> property was
		*	set on this instance.
		*	
		*	If no <code>css</code> property
		*	has been set, this will return null.
		*/
		function get stylesheet():StyleSheet
	}
}