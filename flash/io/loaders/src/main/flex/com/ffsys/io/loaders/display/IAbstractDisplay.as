package com.ffsys.io.loaders.display {
	
	import flash.events.IEventDispatcher;
	import com.ffsys.core.IDestroy;
	
	/**
	*	Abstract interface for loaded assets that
	*	can be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public interface IAbstractDisplay
		extends IDestroy,
				IEventDispatcher {
	}
}