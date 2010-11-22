package com.ffsys.ui.runtime {

	import com.ffsys.ui.containers.Canvas;
	
	/**
	*	A document is the top level view that the loaded
	*	view definition document is rendered into.
	*	
	*	This object that will be added to the parent
	*	display list object specified when the call to
	*	load the runtime view was made.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class Document extends Canvas
		implements 	IDocument {
			
		private var _css:Array;
		private var _binding:Object = new Object();
		
		/**
		*	Creates a <code>Document</code> instance.
		*/
		public function Document()
		{
			super();
		}
		
		/**
		*	List of css files to load.
		*/
		public function get css():Array
		{
			return _css;
		}
		
		public function set css( val:Array ):void
		{
			_css = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get binding():Object
		{
			return _binding;
		}
	}
}