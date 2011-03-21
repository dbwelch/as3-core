package org.flashx.ui.data
{
	import org.flashx.core.IDestroy;
	import org.flashx.core.IStringIdentifier;
	
	import org.flashx.ui.core.IComponent;
	
	/**
	*	Describes the contract for user interface component data binding.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public interface IDataBinding extends IStringIdentifier, IDestroy
	{
		/**
		* 	Clears all data associated with this binding and triggers
		* 	a clear notification if this data binding already has data
		* 	defined.
		*/
		function clear():void;
		
		/**
		* 	The components that are observing this binding.
		*/
		function get observers():Vector.<IComponent>;
		
		/**
		* 	Removes an observer from this data binding.
		* 
		* 	@param observer The component observer to remove.
		* 
		* 	@return A boolean indicating whether the observer was removed.
		*/
		function removeObserver( observer:IComponent ):Boolean;
	
		/**
		*	Determines whether this data binding has an observer.
		* 
		* 	@param observer The component to test for existence as an observer.
		* 
		* 	@return A boolean indicating whether the component is an observer
		* 	of this data binding.
		*/
		function hasObserver( observer:IComponent ):Boolean;
	
		/**
		* 	Adds an observer to this data binding.
		* 
		* 	The specified observer must be non-null and not exist
		* 	in the list of observers to be added successfully.
		* 
		* 	@param observer The component observer to add.
		*/
		function addObserver( observer:IComponent ):void;
	
		/**
		* 	Sends a notification to all observers registered with this data binding.
		* 
		* 	@param notification The notification to send to the observers.
		*/
		function notify( notification:IDataBindingNotification ):void;
		
		/**
		* 	The data that this data binding encapsulates.
		*/
		function get data():Object;
		function set data( value:Object ):void;
	}
}