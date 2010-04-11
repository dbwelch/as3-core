package com.ffsys.io.loaders.display {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	
	/**
	*	Abstract class for instances that contain loaded
	*	data and can be added to the display list of a Flex
	*	application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class FlexAbstractDisplay extends UIComponent 
		implements IAbstractDisplay {
		
		/**
		*	@private	
		*/
		public function FlexAbstractDisplay()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function destroy():void
		{
			//
		}
	}
}