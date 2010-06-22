package com.ffsys.ui.states
{
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	/**
	*	Represents the graphical components for a single state.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ViewState extends Object
		implements IViewState
	{
		private var _graphics:Vector.<IComponentGraphic>;
		
		/**
		* 	Creates a <code>ViewState</code> instance.
		*/
		public function ViewState()
		{
			super();
			_graphics = new Vector.<IComponentGraphic>();
		}
		
		/**
		*	A vector of graphics associated with the state.	
		*/
		public function get graphics():Vector.<IComponentGraphic>
		{
			return _graphics;
		}
	}
}