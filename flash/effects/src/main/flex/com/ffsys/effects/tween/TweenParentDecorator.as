package com.ffsys.effects.tween {
	
	/*
	*	Decorates ITween instance with parent lookup.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.08.2007
	*/
	internal class TweenParentDecorator extends Object {
		
		private var _parent:ITween;
		
		public function TweenParentDecorator()
		{
			super();
		}
		
		public function set parent( val:ITween ):void
		{
			_parent = val;
		}
		
		public function get parent():ITween
		{
			return _parent;
		}
		
	}
	
}
