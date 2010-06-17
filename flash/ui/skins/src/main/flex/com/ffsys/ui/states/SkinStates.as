package com.ffsys.ui.states
{
	/**
	*	Encapsulates all the view states for a component skin.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class SkinStates extends Object
		implements ISkinStates
	{
		private var _main:IViewState;
		private var _disabled:IViewState;
		
		private var _down:IViewState;
		private var _over:IViewState;
		
		/**
		* 	Creates a <code>SkinStates</code> instance.
		*/
		public function SkinStates()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get main():IViewState
		{
			return _main;
		}
		
		public function set main( state:IViewState ):void
		{
			_main = state;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get disabled():IViewState
		{
			return _disabled;
		}

		public function set disabled( state:IViewState ):void
		{
			_disabled = state;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get down():IViewState
		{
			return _down;
		}

		public function set down( state:IViewState ):void
		{
			_down = state;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get over():IViewState
		{
			return _over;
		}

		public function set over( state:IViewState ):void
		{
			_over = state;
		}
	}
}