package com.ffsys.ui.states
{
	import flash.display.DisplayObject;
	
	/**
	*	Represents a view state that has a icon graphic
	* 	and an icon.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class IconBackgroundState extends BackgroundState
	{
		private var _icon:DisplayObject;
		
		/**
		* 	Creates a <code>IconBackgroundState</code> instance.
		*/
		public function IconBackgroundState()
		{
			super();
		}
		
		/**
		* 	The icon graphic.
		*/
		public function get icon():DisplayObject
		{
			return _icon;
		}
		
		public function set icon( icon:DisplayObject ):void
		{
			_icon = icon;
		}
	}
}