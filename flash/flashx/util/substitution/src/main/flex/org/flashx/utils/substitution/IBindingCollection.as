package org.flashx.utils.substitution {
	
	/**
	*	Describes the contract for Objects that manage a collection of
	*	Binding instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public interface IBindingCollection {
		
		function clear():void;
		function getLength():int;
		
		function addBinding( binding:IBinding ):void;
		function hasBinding( binding:IBinding ):Boolean;
		function getBindingIndex( binding:IBinding ):int;
		function removeBinding( binding:IBinding ):Boolean;
		
		function getBindingAt( index:int ):IBinding;
		function hasBindingAt( index:int ):Boolean;
		function removeBindingAt( index:int ):Boolean;
		
		function getBindingByPrefix( prefix:String ):IBinding;
		function removeSubstitutionByPrefix( prefix:String ):Boolean;
		
		function clone():IBindingCollection;
	}
}