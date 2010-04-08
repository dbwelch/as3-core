package com.ffsys.utils.substitution {
	
	/**
	*	Describes the contract for Objects that manage a collection of
	*	SubstitutionNamespace instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public interface ISubstitutionNamespaceCollection {
		
		function clear():void;
		function getLength():int;
		
		function addSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):void;
		function hasSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):Boolean;
		function getSubstitutionNamespaceIndex( substitutionNamespace:ISubstitutionNamespace ):int;
		function removeSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):Boolean;
		
		function getSubstitutionNamespaceAt( index:int ):ISubstitutionNamespace;
		function hasSubstitutionNamespaceAt( index:int ):Boolean;
		function removeSubstitutionNamespaceAt( index:int ):Boolean;
		
		function getSubstitutionNamespaceByPrefix( prefix:String ):ISubstitutionNamespace;
		function removeSubstitutionByPrefix( prefix:String ):Boolean;
		
		function clone():ISubstitutionNamespaceCollection;
		
	}
	
}
