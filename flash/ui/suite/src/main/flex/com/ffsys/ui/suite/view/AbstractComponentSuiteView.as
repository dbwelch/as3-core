package com.ffsys.ui.suite.view {
	
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.text.SingleLineTextField;
	
	import com.ffsys.swat.view.AbstractSwatView;
	
	/**
	*	Abstract super class for the component test suite views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractComponentSuiteView extends AbstractSwatView {
		
		public var heading:SingleLineTextField;
		
		/**
		*	Creates a <code>AbstractComponentSuiteView</code> instance.
		*/
		public function AbstractComponentSuiteView()
		{
			super();
		}
		
		protected function createHeading(
			title:String, parent:DisplayObjectContainer ):void
		{
			if( title && parent )
			{
				title = title.toUpperCase();
				heading =
					textFieldFactory.single( title, null, { color: 0xa9a9a9, bold: true, size: 18 } );
				parent.addChild( heading );
			}
		}
	}
}