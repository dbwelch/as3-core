package com.ffsys.utils.collections.properties {
	
	import com.ffsys.utils.collections.strings.IStringAccess;
	
	/**
	*	Describes the contract for instances that provide access
	*	to properties by type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.11.2007
	*/
	public interface IPropertyAccess
		extends IStringAccess {
		function getPropertyById(
			id:String, collection:String = null ):Object;
		function getNumberById(
			id:String, collection:String = null ):Number;
		function getBooleanById(
			id:String, collection:String = null ):Boolean;
		function getArrayById(
			id:String, collection:String = null ):Array;
	}
}