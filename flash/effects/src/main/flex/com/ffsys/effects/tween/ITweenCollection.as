package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that consist of a collection of other ITween instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenCollection
		extends ITween,
				ITweenEventProxy,
				ITweenCollectionList {
	}
}