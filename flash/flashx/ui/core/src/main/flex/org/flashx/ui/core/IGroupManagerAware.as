package org.flashx.ui.core
{
	public interface IGroupManagerAware
	{
		/**
		* 	The group manager reference.
		*/
		function get groupManager():IComponentGroupManager;
		function set groupManager( value:IComponentGroupManager ):void;
		
		//function get groupIdentifier():String;
		//function set groupIdentifier( value:String ):void;
	}
}