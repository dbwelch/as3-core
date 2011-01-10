package com.ffsys.ui.runtime {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.io.xml.IParser;	
	
	import com.ffsys.ui.dom.*;	
	
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
		*	The document created for the last load request.
		*/
		function get document():IDocument;
		
		/**
		* 	The parser to use for the runtime document.
		*/
		function get parser():IRuntimeParser;
		function set parser( value:IRuntimeParser ):void;
		
		/**
		*	Loads the xml document defining the runtime view to render.
		*	
		*	The parent display object that the view will be rendered into
		*	must be on the display list.
		*	
		*	@param request The url request to load the xml document from.
		*	@param parent The display object that the view document will be
		*	added to.
		* 	@param bindings Data bindings to expose when parsing the runtime
		* 	xml document.
		*/
		function getLoaderQueue(
			request:URLRequest,
			parent:DisplayObjectContainer = null,
			... bindings ):ILoaderQueue;
		
		/**
		* 	Start the load process on the encapsulated queue.
		*/
		function load():void;
	}
}