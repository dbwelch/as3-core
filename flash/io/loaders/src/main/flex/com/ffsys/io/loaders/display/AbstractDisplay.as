/**
*	Helper classes for loaders that represent implementations that can be added to the display list.
*/
package com.ffsys.io.loaders.display {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	*	Abstract super class for loaded assets that can
	*	be attach to the display list of a Flash application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class AbstractDisplay extends Sprite
		implements IAbstractDisplay {
		
		/**
		*	@private	
		*/		
		public function AbstractDisplay()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function destroy():void
		{
			//no references to clean at the moment : 8/12/2007
		}
	}
}