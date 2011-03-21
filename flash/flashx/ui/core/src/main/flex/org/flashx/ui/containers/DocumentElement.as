package org.flashx.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.geom.*;
	
	import org.flashx.ioc.*;
	
	import org.flashx.ui.core.*;
	import org.flashx.ui.common.*;	
	import org.flashx.ui.layout.*;
	
	/**
	*	An abstract super class for block and inline elements.
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