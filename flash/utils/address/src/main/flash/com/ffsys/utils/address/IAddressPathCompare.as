package com.ffsys.utils.address {
	
	/**
	*	Describes the methods and properties available
	*	for performing comparison between <code>IAddressPath</code>
	*	instances.
	*	
	*	@see com.ffsys.utils.address.AddressPath
	*	@see com.ffsys.utils.address.IAddressPath
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2007
	*/
	public interface IAddressPathCompare {
		
		/**
		*	Determines whether two address paths are equal.
		*	
		*	Equality is determined by both <code>IAddressPath</code>
		*	instances having the same length and every path element
		*	being exactly equal using strict equality.
		*	
		*	@param compare The <code>IAddressPath</code> to
		*	compare against this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether the two
		*	<code>IAddressPath</code> instances are equal.
		*/
		function equals( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	is contained in this <code>IAddressPath</code> beginning
		*	from the start of this <code>IAddressPath</code>.
		*	
		*	If the two <code>IAddressPath</code> instances
		*	are equal this method will return true.
		*	
		*	@param compare The <code>IAddressPath</code> to compare against
		*	this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating
		*	whether this <code>IAddressPath</code>
		*	starts with the compare <code>IAddressPath</code>.
		*/
		function starts( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	is contained in this <code>IAddressPath</code> beginning
		*	from the end of this <code>IAddressPath</code>.
		*	
		*	If the two <code>IAddressPath</code> instances are equal this
		*	method will return <code>true</code>.
		*	
		*	@param compare The <code>IAddressPath</code>
		*	to compare against this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	this <code>IAddressPath</code> ends with the
		*	compare <code>IAddressPath</code>.
		*/
		function ends( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	is a direct parent of this <code>IAddressPath</code>.
		*	
		*	@param compare The <code>IAddressPath</code> to
		*	compare against this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether the compare
		*	<code>IAddressPath</code> is the direct parent
		*	of this <code>IAddressPath</code>.
		*/
		function parent( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	is an ancestor of this <code>IAddressPath</code>.
		*	
		*	@param compare The <code>IAddressPath</code> to
		*	compare against this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether the compare
		*	<code>IAddressPath</code> is an ancestor of
		*	this <code>IAddressPath</code>.
		*/
		function ancestor( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	last element is a sibling of the last elements of
		*	this <code>IAddressPath</code>.
		*	
		*	If the two <code>IAddressPath</code> instances are
		*	equal this method will return false.
		*	
		*	@param compare The <code>IAddressPath</code> to
		*	compare against this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether the compare
		*	<code>IAddressPath</code> is a sibling path of
		*	this <code>IAddressPath</code>.
		*/
		function sibling( compare:IAddressPath ):Boolean;
		
		/**
		*	Determines whether the compare <code>IAddressPath</code>
		*	is a child of this <code>IAddressPath</code>.
		*	
		*	@param compare The <code>IAddressPath</code> to compare against
		*	this <code>IAddressPath</code>.
		*	
		*	@return A <code>Boolean</code> indicating
		*	whether the compare <code>IAddressPath</code>
		*	a child of this <code>IAddressPath</code>.
		*/
		function child( compare:IAddressPath ):Boolean;
	}
	
}
