package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	/**
	*	Describes the contract for the loader that loads
	*	the xml document that defines the view and any dependencies
	*	declared in the view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public interface IRuntimeLoader
		extends IEventDispatcher {
		
		/**
		*	Loads the xml document defining the runtime view to render.
		*	
		*	The parent display object that the view will be rendered into
		*	must be on the display list.
		*	
		*	@param request The url request to load the xml document from.
		*	@param parent The display object that the view document will be
		*	added to.
		*/
		function load(
			request:URLRequest,
			parent:DisplayObjectContainer ):void;
	}
}