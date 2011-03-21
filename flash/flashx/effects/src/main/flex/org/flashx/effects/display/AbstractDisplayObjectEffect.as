package org.flashx.effects.display {

	import flash.display.DisplayObject;
	
	import org.flashx.effects.AbstractObjectEffect;
	
	/**
	*	Abstract base class for DisplayObject effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class AbstractDisplayObjectEffect extends AbstractObjectEffect {
	
		private var _displayObject:DisplayObject;
		
		/**
		* 	Creates an <code>AbstractDisplayObjectEffect</code> instance.
		*/
		public function AbstractDisplayObjectEffect(
			displayObject:DisplayObject = null, properties:Array = null )
		{
			super( properties );
			this.displayObject = displayObject;
		}
		
		/**
		* 	The display object this effect is operating on.
		*/
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}		
		
		public function set displayObject( val:DisplayObject ):void
		{
			_displayObject = val;
		}
	}
}