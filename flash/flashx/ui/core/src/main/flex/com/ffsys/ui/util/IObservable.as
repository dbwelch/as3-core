package com.ffsys.ui.util
{
	/**
	 * 	This describes an observable object. 
	 * 	It can be implemented and subclassed to represent an object that the application wants to 
	 * 	have observed.
	 * 
	 * 	An observable object can have one or more observers. An observer may be any object that 
	 * 	implements interface Observer. After an observable instance changes, an application calling 
	 * 	the Observable's notifyObservers method causes all of its observers to be notified of the 
	 * 	change by a call to their update method.
	 * 
	 * 	@author Vish Vishvanath
	 * 	@since 1 December 2010
	 * 
	 */
	public interface IObservable
	{
		/**
		 *	Adds an observer to the set of observers for this object, provided that it is not the 
		 * 	same as some observer already in the set. 
		 * 	
		 * 	@param obs
		 */
		function addObserver( obs:IObserver ):void;
		
		/**
		 *	Indicates that this object has no longer changed, or that it has already notified all 
		 * 	of its observers of its most recent change, so that the hasChanged method will now 
		 * 	return false. 
		 */
		function clearChanged():void;
		
		/**
		 *	Returns the number of observers of this Observable object.
		 * 
		 * 	@return 
		 */
		function countObservers():int;
		
		/**
		 *	Deletes an observer from the set of observers of this object. 
		 * 
		 * 	@param obs
		 */
		function deleteObserver( obs:IObserver ):void;
		
		/**
		 *	Clears the observer list so that this object no longer has any observers. 
		 */
		function deleteObservers():void;
		
		/**
		 *	Tests if this object has changed.
		 *  
		 * 	@return 
		 * 
		 */
		function hasChanged():Boolean;
		
		/**
		 *	If this object has changed, as indicated by the hasChanged method, then notify all of 
		 * 	its observers and then call the clearChanged method to indicate that this object has no 
		 * 	longer changed.
		 */
		function notifyObservers():void;
		
		/**
		 *	Marks this Observable object as having been changed; the hasChanged method will now 
		 * 	return true.
		 */
		function setChanged():void;
		
		
	}
}