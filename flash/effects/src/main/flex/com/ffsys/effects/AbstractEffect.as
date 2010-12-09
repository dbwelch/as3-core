package com.ffsys.effects {
	
	import com.ffsys.effects.tween.TweenGroup;
	
	/**
	*	Abstract super class for all effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public class AbstractEffect extends TweenGroup
		implements IEffect {
		
		/**
		* 	Creates an <code>AbstractEffect</code> instance.
		*/
		public function AbstractEffect()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function composite( effect:IEffect ):void
		{
			addTween( effect );
		}
	}
}