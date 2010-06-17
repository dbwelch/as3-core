package com.ffsys.ui.suite.view {
	
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.containers.VerticalBox;
	import com.ffsys.ui.components.text.Label;
	
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
		
		public var vbox:VerticalBox;
		public var heading:Label;
		
		/**
		*	Creates a <code>AbstractComponentSuiteView</code> instance.
		*/
		public function AbstractComponentSuiteView()
		{
			super();
		}
		
		protected function createHeading(
			title:String, parent:DisplayObjectContainer ):Label
		{
			if( title && parent )
			{
				title = title.toUpperCase();
				heading = new Label( title );
				parent.addChild( heading );
			}
			return heading;
		}
	}
}