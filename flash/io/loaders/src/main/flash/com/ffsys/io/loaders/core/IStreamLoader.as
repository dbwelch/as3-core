package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for Objects that can behave
	*	in a streaming manner. Although all load processes
	*	are essentially stream this contract applies to the
	*	load processes that can playback during a load
	*	operation. This applies to Sound and Video types.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2007
	*/
	public interface IStreamLoader extends ILoader {
		
		function set streaming( val:Boolean ):void;
		function get streaming():Boolean;
	}
	
}
