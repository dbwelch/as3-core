package org.flashx.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that consist of a collection of other ITween instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenCollectionList {
		
		/**
		*	Gets an Array of all the Tween instances in this collection.
		*
		*	@return an Array of all the Tween instances in this collection
		*/
		function getAllTweens():Array;
		
		/**
		*	Adds an arbritrary number of ITween instances to this collection.
		*
		*	@param ...args a list of ITween instances
		*/
		function addTweens( ...args ):void;
		
		/**
		*	Adds an individual ITween to this collection.
		*
		*	@param val the ITween to add
		*
		*	@return an int indicating the new length of the collection
		*/
		function addTween( val:ITween ):int;
		
		/**
		*	Removes an ITween instance from the collection.
		*
		*	Note that it searches for the ITween recursively, if this collection
		*	contains other ITweenCollection instances we also look in the child
		*	collections for the target ITween that we are attempting to remove.
		*
		*	@param val the ITween to remove
		*
		*	@return a Boolean indicating whether the ITween was removed
		*/
		function removeTween( val:ITween ):Boolean;
		
		/**
		*	Gets an ITween at a given index within this collection.
		*
		*	@param index the index to retrieve the ITween from
		*
		*	@return the ITween instance at the given index or null if none is found
		*/
		function getTweenAt( index:int ):ITween;
		
		/**
		*	Removes an ITween at a given index.
		*
		*	@param index the index to remove the ITween
		*
		*	@return the removed ITween if removed successfully or null if it could not be removed
		*/
		function removeTweenAt( index:int ):ITween;
		
		/**
		*	Gets the number of child ITween instances in this collection 
		*/
		function getLength():int;
		
		/**
		*	Gets the last ITween in this collection or null if the index is out of bounds
		*/
		function last():ITween;
		
		/**
		*	Gets the first ITween in this collection or null if the collection is empty
		*/		
		function first():ITween;
		
		/**
		*	Clears all ITween instances stored in this collection.
		*/		
		function clear():void;
		
		/**
		*	Determines whether the ITweenCollectionList is empty or not.
		*/
		function isEmpty():Boolean;
		
		/**
		*	Gets the underlying Array used to store the child ITween instances.
		*/
		function get targets():Array;
		
		/**
		*	
		*/
		function getTweensByType( type:Class ):ITweenCollectionList;
		
		function merge(
			source:ITweenCollectionList,
			destination:ITweenCollectionList = null ):ITweenCollectionList;
	}
	
}
