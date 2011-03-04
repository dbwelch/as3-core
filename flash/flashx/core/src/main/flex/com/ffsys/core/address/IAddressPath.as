package com.ffsys.core.address {
	
	import com.ffsys.core.IAddress;
	import com.ffsys.core.IDelimiter;
	import com.ffsys.core.IDestroy;
	
	/**
	*	Describes the contract for instances that represent
	*	an address path.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2007
	*/
	public interface IAddressPath
		extends IAddressPathCompare,
				IAddressPathFinder,
				IAddress,
				IDelimiter,
				IDestroy {
		
		/**
		*	Determines whether a query string should
		*	be stripped when parsing the raw <code>address</code>.
		*/	
		function set stripQueryString( val:Boolean ):void;
		function get stripQueryString():Boolean;				
					
	/*
	*	Gets the clean String address representation of this
	*	IAddressPath. Note that the address property always
	*	stores the raw address representation as supplied to
	*	the constructor or by setting the address property.
	*/
	
		/**
		*	Gets the <code>String</code> address based on
		*	the current	state of the underlying elements
		*	for this instance. Note that this differs from
		*	the <code>address</code> property which will
		*	always return the original source address.
		*	
		*	@return The address currently represented
		*	by the path elements for this instance.
		*/
		function getAddress():String;
		
	/*
	*	Determines whether a given element String
	*	contains the delimiter assigned to this instance.	
	*/
		function hasDelimiter( element:String ):Boolean;
		
	/*
	*	Returns the index of the first path element contained
	*	in this IAddressPath that equals the element passed.
	*/
	
		/**
		*	Attempts to locate the index of a given path element
		*	in this instance. Returns -1 if the path element could
		*	not be found in this instance otherwise the index of the
		*	path element.
		*	
		*	@param element The path element to find the index of.
		*	
		*	@return The integer index of the path element or -1
		*	if the element could not be found .
		*/	
		function getPathElementIndex( element:String ):int;
		
	/*
	*	Given a String path element this method returns an
	*	Array containing all the available elements split
	*	on the delimiter. If the element arguments does not
	*	contain the delimiter this method returns an Array
	*	of length one containing the single element argument.
	*/
	
		/**
		*	Gets an <code>Array</code> of path elements given
		*	a path element candidate. If the element does not
		*	contain the <code>delimiter</code> assigned to this
		*	instance an Array with the element passed as it's
		*	sole entry is returned. If the path element contains
		*	the <code>delimiter</code> then an <code>Array</code>
		*	of the elements contained within the passed element
		*	is returned.
		*	
		*	@param element The path element candidate.
		*	
		*	@return An Array of all the elements represented by
		*	the passed path element candidate.
		*/	
		function getPathElements( element:String ):Array;
		
	/*
	*	Adds one or more path elements to this IAddressPath
	*	instance, if the element argument contains the delimiter
	*	then the element argument is split on the delimiter using
	*	the parse() method and the number of elements in the Array
	*	returned from calling parse() are added to this IAddressPath.
	*/
	
		/**
		*	Adds path element(s) to this instance.
		*	
		*	If the element passed does not contain the
		*	<code>delimiter</code> then a single element
		*	is added.
		*	
		*	If the passed element contains the <code>delimiter</code>
		*	then all the elements of the passed element are added.
		*	
		*	@param element The path element(s) to add to this instance.
		*	
		*	@return An integer indicating the new length of this instance.
		*/	
		function addPathElement( element:String ):int;
		
	/*
	*	Removes all occurences of element from this IAddressPath.
	*	Note this method is greedy and will remove all instances
	*	of element.
	*/
		
		/**
		*	Removes one or more path elements.
		*	
		*	If the <code>element</code> parameter
		*	contains the <code>delimiter</code> then
		*	this method will attempt to remove all the
		*	elements contained within the <code>element</code>
		*	parameter.
		*	
		*	@param element The element(s) to remove from this instance.
		*	
		*	@return A Boolean indicating whether any
		*	elements were removed.
		*/		
		function removePathElements( element:String ):Boolean;
		
	/*
	*	Removes all path elements that match a given RegExp.	
	*/
		
		/**
		*	Removes path elements based on a given regular
		*	expression.
		*	
		*	@param regex The <code>RegExp</code> used
		*	to match each element that should be removed.
		*	
		*	@return A <code>Boolean</code> indicating whether any
		*	elements were removed.
		*/		
		function removePathElementsByMatch( regex:RegExp ):Boolean;
		
	/*
	*	Inserts one or more path elements at a given index.
	*	If the element passed contains the delimiter, then
	*	the number of parts inserted should be equal to the
	*	length of the Array returned from
	*	getPathElements( element ).
	*/
		
		/**
		*	Inserts one or more path elements into this instance
		*	at a given <code>index</code>.
		*	
		*	@param index The index to insert the path element(s).
		*	@param element The path element candidate to insert.
		*	
		*	@return The integer length of this instance.
		*/		
		function insertPathElementAt( index:int, element:String ):int;
		
	/*
	*	Sets one or more path elements at a given index. If the index
	*	is less then zero the path elements(s) will be inserted
	*	at the beginning, if the index is greater than getLength() - 1
	*	the element(s) will be added to the path elements for this
	*	IAddressPath.
	*/		
		
		/**
		*	Sets an element at a given <code>index</code>.
		*	
		*	@param index The <code>index</code> for the element.
		*	@param element The new path element for the given <code>index</code>.
		*	
		*	@return The integer length of this instance.
		*/
		function setPathElementAt( index:int, element:String ):int;
		
		/**
		*	Gets an element at a given <code>index</code>.
		*	
		*	If the <code>index</code> is out of bounds this
		*	method will return <code>null</code>.
		*	
		*	@param index The integer index to retrieve
		*	the element from.
		*	
		*	@return The element at the given
		*	<code>index</code> as a <code>String</code>.
		*/		
		function getPathElementAt( index:int ):String;
		
		/**
		*	Removes an element at a given index.
		*	
		*	If the <code>index</code> parameter is out
		*	of bounds this method will return
		*	<code>null</code>.
		*	
		*	@param The index at which to remove the element.
		*	
		*	@return The removed element.
		*/
		function removePathElementAt( index:int ):String;
		
		/**
		*	Clears all the elements stored within this
		*	instance.
		*	
		*	This has no affect on the original source
		*	<code>address</code>.
		*/
		function clear():void;
		
		/**
		*	Gets the number of elements currently
		*	contained in this instance.	
		*	
		*	@return An integer of the number of
		*	path elements in this instance.
		*/
		function getLength():int;
		
		/**
		*	Removes the first path element in this instance
		*	and returns that element as a <code>String</code>.
		*	
		*	If this instance is currently empty then this
		*	method will return <code>null</code>.
		*	
		*	@return The removed element.
		*/
		function removeFirstPathElement():String;
		
		/**
		*	Removes the last path element in this instance
		*	and returns that element as a <code>String</code>.
		*	
		*	If this instance is currently empty then this
		*	method will return <code>null</code>.
		*	
		*	@return The removed element.
		*/
		function removeLastPathElement():String;
		
		/**
		*	Gets the first path element as a <code>String</code>.
		*	
		*	If this instance is currently empty then this
		*	method will return <code>null</code>.
		*	
		*	@return The first element in this instance.
		*/
		function getFirstPathElement():String;
		
		/**
		*	Gets the last path element as a <code>String</code>.
		*	
		*	If this instance is currently empty then this
		*	method will return <code>null</code>.
		*	
		*	@return The last element in this instance.
		*/
		function getLastPathElement():String;
		
		/**
		*	Determines whether this instance is considered
		*	a root path.
		*	
		*	An <code>IAddressPath</code> instance is considered
		*	to be a root path if it is empty (has no elements),
		*	which will be the case if the source address is a
		*	blank string or consists of solely the
		*	<code>delimiter</code>.
		*	
		*	@return A <code>Boolean</code> indicating whether this
		*	instance represents a root path.
		*/
		function isRootPath():Boolean;
		
		/**
		*	Determines whether this instance is considered
		*	to be a top-level path.
		*	
		*	An <code>IAddressPath</code> instance is considered
		*	to be a top-level path if it has a single element.
		*	
		*	@return A <code>Boolean</code> indicating whether this
		*	instance represents a top-level path.
		*/
		function isTopLevelPath():Boolean;
		
		/**
		*	Concatenates all the elements contained in the
		*	<code>target</code> instance onto the end of
		*	this instance.
		*	
		*	@param target The <code>target</code>
		*	instance to concatenate elements from.
		*	
		*	@return An integer of the number of
		*	path elements in this instance.
		*/
		function concat( target:IAddressPath ):int;
		
		/**
		*	Joins the elements contained in an <code>Array</code>
		*	into a <code>String</code> representation based upon
		*	the current <code>delimiter</code>.
		*	
		*	@param elements An <code>Array</code> of
		*	<code>String</code> path elements to join.
		*	
		*	@return A <code>String</code> address path.
		*/		
		function join( elements:Array = null ):String;
		
		/**
		*	Parses a source <code>address</code> into an
		*	<code>Array</code> of path elements.
		*	
		*	@param address The source address to parse.
		*	@param delimiter The delimiter to use when
		*	parsing the source <code>address</code>.
		*	@param stripQuery A flag indicating whether a
		*	query string should be removed if present.
		*	
		*	@return An <code>Array</code> of path elements.
		*/
		function parse(
			address:String,
			delimiter:String = null,
			stripQuery:Boolean = false ):Array;
		
		/**
		*	Clones this instance with the address path
		*	returned from the <code>getAddress</code> method.
		*	
		*	@return The cloned <code>IAddressPath</code> instance.
		*/
		function clone():IAddressPath;
	}	
}