package com.ffsys.swat.as3.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.swat.core.SwatFlashVariables;
	
	/**
	*	Encapsulates the data passed in via flash variables
	*	from the container embedding this movie.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ApplicationFlashVariables extends SwatFlashVariables {
		
		private var _mode:String = "auto";
		/**
		*	Creates a <code>ApplicationFlashVariables</code> instance.
		*	
		*	@param root The root of the display list hierarchy.
		*/
		public function ApplicationFlashVariables( root:DisplayObject )
		{
			super( root );
		}
		
		/**
		*	Gets the mode to run the application in.
		*	
		*	@return The application runtime mode.
		*/
		public function get mode():String
		{
			return _mode;
		}
		
		/**
		*	Sets the mode to run the application in.
		*	
		*	@param mode The application runtime mode.
		*/
		public function set mode( mode:String ):void
		{
			_mode = mode;
		}
	}
}