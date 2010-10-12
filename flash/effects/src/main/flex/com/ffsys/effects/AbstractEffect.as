package com.ffsys.effects {
	
	import com.ffsys.effects.tween.TweenGroup;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	/* END OBJECT_INSPECTOR REMOVAL */
	
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
		
		public function AbstractEffect()
		{
			super();
		}
		
		/*
		*	IEffect implementation.
		*/
		public function composite( effect:IEffect ):void
		{
			addTween( effect );
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function toString():String
		{	
			var output:ObjectInspector = new ObjectInspector( this );
			return output.getComplexInspection();
		}
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}
