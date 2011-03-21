package org.flashx.effects.array {
	
	import org.flashx.effects.AbstractObjectEffect;
	
	/**
	*	Abstract super class for effects that operate on Arrays.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class AbstractArrayEffect extends AbstractObjectEffect {
		
		protected var _targetArray:Array;
		
		public function AbstractArrayEffect( targetArray:Array, properties:Array )
		{
			super( properties );
			this.targetArray = targetArray;
		}
		
		public function set targetArray( val:Array ):void
		{
			_targetArray = val;
		}
		
		public function get targetArray():Array
		{
			return _targetArray;
		}		
		
	}
	
}
