package org.flashx.effects.tween {
	
	import org.flashx.effects.tween.TweenEvent;
	
	/*
	*	Describes the contract for instancs that proxy
	*	ITweenCollection events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.08.2007
	*/
	public interface ITweenCollectionEventProxy
		extends ITweenEventProxy {
			
		function dispatchCollectionCompleteEvent(
			event:TweenEvent ):void;
			
	}
	
}
