package com.ffsys.ui.containers
{

	public interface IDivContainer extends IContainer
	{
		
		/**
		* 	The display mode for this container.
		*/
		function get display():String;
		function set display( value:String ):void;	
	}

}

