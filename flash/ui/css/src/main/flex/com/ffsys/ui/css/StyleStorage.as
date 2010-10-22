package com.ffsys.ui.css {
	
	/**
	*	Responsible for storing references to applied styles
	*	and any custom style properties that override the applied
	*	styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public class StyleStorage extends Object {
		
		private var _applied:Array;
		private var _overrides:Object;
		
		/**
		*	Creates a <code>StyleStorage</code> instance.
		*/
		public function StyleStorage()
		{
			super();
		}
		
		/**
		*	An array of objects that represent the styles that
		*	were applied the last time the apply method of the
		*	style sheet was invoked on the target object.	
		*/
		public function get applied():Array
		{
			return _applied;
		}
		
		public function set applied( value:Array ):void
		{
			_applied = value;
		}
		
		/**
		*	Custom style properties set directly rather
		*	than applied from a style sheet.
		*/
		public function get overrides():Object
		{
			if( _overrides == null )
			{
				_overrides = new Object();
			}
			
			return _overrides;
		}
		
		public function set overrides( value:Object ):void
		{
			_overrides = value;
		}
	}
}
