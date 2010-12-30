package com.ffsys.ui.core {
	
	/**
	*	Encapsulates constants that refer to common states
	*	for components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class State extends Object {
		
		/**
		*	The main state for the component.
		*	
		*	This is considered the up state for buttons.
		*/
		public static const MAIN:String = "main";
		
		/**
		*	Represents a mouse over state.
		*/
		public static const OVER:String = "over";
		
		/**
		*	Represents a mouse out state.
		*/
		public static const OUT:String = "out";
		
		/**
		*	Represents a mouse down state.
		*/
		public static const DOWN:String = "down";
		
		/**
		*	Represents a selected state.
		*/
		public static const SELECTED:String = "selected";
		
		/**
		*	Represents a focused state.
		*/
		public static const FOCUSED:String = "focused";
	
		/**
		*	Represents a disabled state.
		*/
		public static const DISABLED:String = "disabled";
	}
}