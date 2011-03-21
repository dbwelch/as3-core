package org.flashx.ui.common.flash {
	
	import flash.display.Graphics;
	
	/**
	*	Describes the contract for shape instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface IShape extends IDisplayObject {
		
		function get graphics():Graphics;
	}
}