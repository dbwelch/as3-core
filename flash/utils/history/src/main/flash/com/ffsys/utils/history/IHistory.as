package com.ffsys.utils.history {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IStrictMode;
	
	/**
	*	Describes the methods and properties for instances
	*	that store a list of historical items.
	*	
	*	For example, it could be all the pages that a user
	*	visits in an application or a history of interactions
	*	with a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.09.2007
	*/
	public interface IHistory 
		extends IStrictMode,
				IEventDispatcher {
		
		/**
		*	Adds an item to the history.
		*	
		*	@param value The <code>Object</code> to add to the history.
		*/
		function addHistoryItem( value:Object ):void;
		
		/**
		*	Removes the first occurence of an item from the history.
		*
		*	@param value The history item to remove.
		*
		*	@return A Boolean indicating whether the item was removed.
		*/
		function removeHistoryItem( value:Object ):Boolean;
		
		/**
		*	Gets a history item at a given index, returns
		*	<code>null</code> if the index is invalid.
		*
		*	@param index The index to retrieve the history item from.
		*
		*	@return The history item at the given index or
		*	<code>null</code> if the index is invalid.
		*/
		function getHistoryItemAt( index:int ):Object;
		
		/**
		*	Removes a history item at a given index.
		*
		*	@param index The index to remove the item at.
		*
		*	@return The history item if it was removed
		*	otherwise <code>null</code>.
		*/
		function removeHistoryItemAt( index:int ):Object;
		
		/**
		*	Clears all items stored in the history.
		*/
		function clear():void;
		
		/**
		*	Determines whether the history list has more than one
		*	history item.
		*/
		function hasItems():Boolean;
		
		/**
		*	Determines whether this history list is empty.
		*/
		function isEmpty():Boolean;
		
		/**
		*	Gets the number of items in the history list.
		*/
		function getLength():int;
	
		/**
		*	The current <code>position</code> of the history
		*	pointer.
		*	
		*	When a history item is added the pointer is automatically
		*	moved to point to the added history item. 
		*/
		function set position( index:int ):void;
		function get position():int;
		
		/**
		*	The maximum number of history items that can be stored
		*	before purging occurs. Purging behaves in a FIFO manner.
		*/		
		function set maximum( value:int ):void;
		function get maximum():int;
		
		/**
		*	Determines whether the history list has an item
		*	beyond the current position.
		*
		*	This will be true if the list is not empty and the current
		*	position is less than the length of the list minus one.
		*	
		*	@return A <code>Boolean</code> indicating whether a
		*	next item is available.
		*/
		function hasNext():Boolean;
		
		/**
		*	Determines whether the history list has an item prior
		*	to the current position.
		*
		*	This will be true if the history list is not empty and
		*	the current position is greater than zero.
		*	
		*	@return A <code>Boolean</code> indicating whether a
		*	previous item is available.
		*/
		function hasPrevious():Boolean;
		
		/**
		*	Moves the position to point to the first item in the list.
		*/
		function first():Boolean;
	
		/**
		*	Moves the position to point to the last item in the list.
		*/
		function last():Boolean;
		
		/**
		*	Move the position to the next item in the history list.
		*
		*	If no next item is available this method will return
		*	<code>false</code>.
		*/
		function next():Boolean;
		
		/**
		*	Moves the position to the previous item in the history list.
		*
		*	If no previous item is available this method will return
		*	<code>false</code>.
		*/
		function previous():Boolean;
		
		/**
		*	Gets the <code>Object</code> the history position
		*	is currently pointing to or <code>null</code> if there are no
		*	history items.
		*	
		*	@return The history item at the current <code>position</code>.
		*/
		function get item():Object;
		
		/**
		*	Determines whether a given value exists
		*	in this history list.
		*	
		*	@param value The <code>Object</code> to search for.
		*	
		*	@return A <code>Boolean</code> indicating whether the
		*	value exists in the history list.
		*/
		function contains( value:Object ):Boolean;
		
		/**
		*	Determines whether duplicate values are allowed
		*	in the history list.
		*/		
		function set allowDuplicateValues( val:Boolean ):void;
		function get allowDuplicateValues():Boolean;
	
		/**
		*	Determines whether <code>null</code> values are allowed
		*	in the history list.
		*/	
		function set allowNullValues( val:Boolean ):void;
		function get allowNullValues():Boolean;
	}
}