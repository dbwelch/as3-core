package org.flashx.effects {
	
	import org.flashx.effects.tween.ITween;
	import org.flashx.effects.tween.ITweenEventProxy;
	
	/**
	*	Describes the contract for classes that represent
	*	distinct effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface IEffect
		extends ITween,
				ITweenEventProxy {
					
		function composite( effect:IEffect ):void;
	}
}