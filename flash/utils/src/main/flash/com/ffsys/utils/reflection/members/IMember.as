package com.ffsys.utils.reflection.members {
	
	/**
	*	Describes the contract for instances that are
	*	member properties of a Class. This includes methods,
	*	public member variables and accessors.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public interface IMember {
		function set name( val:String ):void;
		function get name():String;
		
		function set declaredBy( val:String ):void;
		function get declaredBy():String;
		
		function set uri( val:String ):void;
		function get uri():String;
		
		/*
			*	if the member is a variable this compares against the
			*	type of the variable, if the member is a method this
			*	compares against the return type of the method.		
		*/
		
		/**
		*	Determines whether this member value is null.
		*/
		//function isNull():Boolean;		
	}
	
}
