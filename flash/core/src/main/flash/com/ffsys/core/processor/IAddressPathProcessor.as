package com.ffsys.core.processor {
	
	import com.ffsys.core.address.IAddressPath;
	
	/**
	*	Describes the contract for instances that perform
	*	processing of a property hierarchy using an
	*	<code>IAddressPath</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.02.2008
	*/
	public interface IAddressPathProcessor extends IProcessor {
		
		/**
		*	The <code>IAddressPath</code> that
		*	this processor is operating on.
		*/
		function set addressPath( val:IAddressPath ):void;
		function get addressPath():IAddressPath;
		
		/**
		*	Determines whether the <code>IAddressPath</code>
		*	is a top-level request.
		*	
		*	@return A <code>Boolean</code> indicating
		*	if the path is top-level.
		*/
		function isTopLevelRequest():Boolean;
		
		/**
		*	Determines whether the <code>IAddressPath</code>
		*	is a root request.
		*	
		*	@return A <code>Boolean</code> indicating
		*	if the path is the root.
		*/		
		function isRootRequest():Boolean;
	}
}