package com.ffsys.ui.data
{
	public interface IDataBindingNotificationObserver
	{
		
		/**
		* 	Invoked by a data binding to notify this component
		* 	observer that the data binding has been modified.
		*/
		function notify( notification:IDataBindingNotification ):void;
	}
}