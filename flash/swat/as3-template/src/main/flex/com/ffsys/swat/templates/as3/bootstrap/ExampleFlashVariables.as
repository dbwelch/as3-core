package com.ffsys.swat.templates.as3.bootstrap {
	
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
	public class ExampleFlashVariables extends SwatFlashVariables {
		
		private var _mode:String = "auto";
		private var _debug:Boolean;
		
		/**
		*	Creates an <code>ExampleFlashVariables</code> instance.
		*	
		*	@param root The root of the display list hierarchy.
		*/
		public function ExampleFlashVariables( root:DisplayObject )
		{
			super( root );
		}
		
		/**
		*	Gets the mode to run the application in.
		*/
		public function get mode():String
		{
			return _mode;
		}
		public function set mode( mode:String ):void
		{
			_mode = mode;
		}
		
		/**
		*	Whether to run in debug mode.
		*/
		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( val:Boolean ):void
		{
			_debug = val;
		}
	}
}