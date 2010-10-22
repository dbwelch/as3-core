package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	
	/**
	*	Concrete implementation of the runtime contract.
	*	
	*	Responsible for loading the xml document describing the
	*	view to be rendered.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class Runtime extends Object {
		
		/**
		*	Creates a <code>Runtime</code> instance.	
		*/
		public function Runtime()
		{
			super();
		}
		
		/**
		*	Loads the xml document defining the runtime view to render.
		*	
		*	The parent display object that the view will be rendered into
		*	must be on the display list.
		*	
		*	@param request The url request to load the xml document from.
		*	@param parent The display object that the runtime view will be
		*	rendered into.
		*	
		*	@return The loader handling the load process.
		*/
		static public function load(
			request:URLRequest,
			parent:DisplayObjectContainer ):IRuntimeLoader
		{
			var loader:IRuntimeLoader = new RuntimeLoader();
			loader.load( request, parent );
			return loader;
		}
	}
}