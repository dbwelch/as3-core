package org.flashx.utils.page
{
	/**
	*	Describes the contract for objects that manage pagination.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.05.2010
	*/
	public interface IPageManager
	{
		/**
		*	Gets the maximum number of items per page.
		* 
		* 	@return The maximum number of items per page. 
		*/
		function get maximum():int;
		
		/**
		*	Sets the maximum number of items per page.
		* 
		* 	@param maximum The maximum number of items per page. 
		*/
		function set maximum( maximum:int ):void;
		
		/**
		*	Gets the zero-based index of the current page.
		* 
		* 	@return The index of the current page.
		*/
		function get index():int;
		
		/**
		* 	Sets the zero-based index of the current page.
		* 
		* 	The index is constrained to not be negative
		* 	and not to exceed the total number of pages.
		* 
		* 	If after the index is constrained it equals
		* 	the current index no further processing occurs.
		* 
		* 	@param value The index for the current page.
		*/
		function set index( value:int ):void;
		
		/**
		*	Gets the one-based index of the current page.
		* 
		* 	If there are no pages this will return zero.
		* 
		* 	@return The one-based index of the current page.
		*/
		function get page():int;
		
		/**
		* 	Sets the one-based index of the current page.
		* 
		* 	@param value The one-based index for the current page.
		*/
		function set page( value:int ):void;
		
		/**
		* 	Gets the total number of pages.
		* 
		* 	@return The total number of pages.
		*/
		function get pages():int;
		
		/**
		* 	Determines whether there are any pages.
		* 
		* 	@return Whether there are any pages.
		*/
		function hasPages():Boolean;
		
		/**
		* 	Determines whether we are currently on the first page.
		* 
		* 	@return Whether we are on the first page.
		*/
		function isFirstPage():Boolean;
		
		/**
		* 	Determines whether a previous page is available.
		* 
		* 	@return Whether a previous page is available.
		*/
		function hasPreviousPage():Boolean;
		
		/**
		* 	Determines whether a next page is available.
		* 
		* 	@return Whether a next page is available.
		*/
		function hasNextPage():Boolean;
		
		/**
		* 	Determines whether we are currently on the last page.
		* 
		* 	@return Whether we are on the last page.
		*/
		function isLastPage():Boolean;		
		
		/**
		*	Gets the total number of items to be paginated.
		* 
		* 	@return The total number of items. 
		*/
		function get total():int;
		
		/**
		*	Sets the total number of items to be paginated.
		* 
		* 	@param total The total number of items.
		*/
		function set total( total:int ):void;
		
		/**
		* 	Gets the zero-based pagination start offset.
		* 
		* 	@return The zero-based pagination start offset.
		*/
		function get start():int;
		
		/**
		* 	Gets the zero-based pagination end offset.
		* 
		* 	@return The zero-based pagination end offset.
		*/
		function get end():int;
		
		/**
		* 	The number of items on the current page.
		* 
		* 	@return The number of items on the current page.
		*/
		function get items():int;
		
		/**
		* 	If a next page is available this method will
		* 	increment the index to point to the next page.
		* 
		* 	@return Whether the page was changed.
		*/
		function next():Boolean;
		
		/**
		* 	If a previous page is available this method will
		* 	decrement the index to point to the previous page.
		* 
		* 	@return Whether the page was changed.
		*/
		function previous():Boolean;
		
		/**
		* 	Attempts to navigate to the first page.
		* 
		* 	@return Whether the navigation request succeeded.
		*/
		function first():Boolean;
		
		/**
		* 	Attempts to navigate to the last page.
		* 
		* 	@return Whether the navigation request succeeded.
		*/
		function last():Boolean;
	}
}