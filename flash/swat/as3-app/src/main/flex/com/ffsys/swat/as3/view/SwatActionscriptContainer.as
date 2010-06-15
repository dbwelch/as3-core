package com.ffsys.swat.as3.view {
	
	import com.ffsys.ui.text.*;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class SwatActionscriptContainer extends SwatActionscriptAbstractView {
		
		/**
		*	Creates a <code>SwatActionscriptContainer</code> instance.
		*/
		public function SwatActionscriptContainer()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function createChildren():void
		{
			var factory:TextFieldFactory = new TextFieldFactory();
			var text:SingleLineTextField =
				factory.single( "THIS IS SOME TEXT", null, { color: 0xff0000 } );
				
			addChild( text );
			
			//
			trace("SwatActionscriptContainer::createChildren(), ", configuration );
		}
	}
}