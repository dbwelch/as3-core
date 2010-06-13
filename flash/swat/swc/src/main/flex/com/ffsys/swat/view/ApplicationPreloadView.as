package com.ffsys.swat.view {
	
	import flash.display.Sprite;
	
	/**
	*	View for the application preload sequence.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class ApplicationPreloadView extends Sprite
		implements IApplicationPreloadView {
		
		/**
		*	Creates an <code>ApplicationPreloadView</code> instance.
		*/
		public function ApplicationPreloadView()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/	
		public function created():void
		{
			trace("ApplicationPreloadView::created(), ", this, this.parent );
		}
	}
}