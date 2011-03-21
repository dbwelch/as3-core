package org.flashx.utils.substitution {
	
	/**
	*	Describes the contract for Objects that encapsulate
	*	information pertaining to a Binding.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public interface IBinding {
		
		function set prefix( val:String ):void;
		function get prefix():String;
		
		function set target( val:Object ):void;
		function get target():Object;
		
		function set methodName( val:String ):void;
		function get methodName():String;
		
		function set methodParts( val:int ):void;
		function get methodParts():int;
		
		function merge( substitutionNamespace:IBinding ):void;
		
		function clone():IBinding;
	}
}