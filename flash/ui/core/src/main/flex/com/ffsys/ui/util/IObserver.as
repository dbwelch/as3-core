package com.ffsys.ui.util
{
	/**
	 *	Describes an object that wants to be informed of changes in observable objects.
	 * 
	 * 	@author Vish Vishvanath
	 * 	@since	1 December 2010
	 * 
	 */
	public interface IObserver
	{
		/**
		 *	This method is called whenever the observed object is changed.
		 *  
		 * 	@param object
		 * 	@param message
		 * 
		 */
		function update( object:IObservable, arg:Object ):void;
	}
}
