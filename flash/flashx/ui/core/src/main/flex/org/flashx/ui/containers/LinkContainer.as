package org.flashx.ui.containers
{
	import org.flashx.ui.layout.HorizontalLayout;
	
	/**
	*	Represents a container for button links.
	* 
	*	The default behaviour is to lay out children
	* 	horizontally, you can assign a vertical layout
	* 	if you need links laid out in a vertical manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.12.2010
	*/
	dynamic public class LinkContainer extends Container
	{	
		/**
		* 	Creates a <code>LinkContainer</code> instance.
		*/
		public function LinkContainer()
		{
			super();
			this.layout = new HorizontalLayout();
		}
	}
}