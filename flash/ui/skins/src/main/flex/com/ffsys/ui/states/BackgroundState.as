package com.ffsys.ui.states
{
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	/**
	*	Represents a view state that has a background graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class BackgroundState extends ViewState
	{
		private var _background:IComponentGraphic;
		
		/**
		* 	Creates a <code>BackgroundState</code> instance.
		*/
		public function BackgroundState()
		{
			super();
		}
		
		/**
		* 	The background graphic.
		*/
		public function get background():IComponentGraphic
		{
			return _background;
		}
		
		public function set background( background:IComponentGraphic ):void
		{
			_background = background;
		}
	}
}