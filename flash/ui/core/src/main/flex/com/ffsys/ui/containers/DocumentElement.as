package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.geom.*;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.layout.*;
	
	/**
	*	A container designed to behave like an html div element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.01.2011
	*/
	public class DocumentElement extends Container {
		
		/**
		*	Creates a <code>DocumentElement</code> instance.
		*/
		public function DocumentElement()
		{
			super();
			this.layout = new DocumentLayout();
		}
	}
}