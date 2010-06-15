package com.ffsys.swat.as3.view {
	
	import flash.text.*;
	
	import com.ffsys.ui.text.MultiLineTextField;	
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.view.ApplicationPreloadView;
	
	/**
	*	Custom application preload view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class SwatActionscriptApplicationPreloadView extends ApplicationPreloadView {
		
		private var _txt:MultiLineTextField;
		
		/**
		*	Creates a <code>SwatActionscriptApplicationPreloadView</code> instance.
		*/
		public function SwatActionscriptApplicationPreloadView()
		{
			super();
		}
		
		public function getTextField():MultiLineTextField
		{
			return _txt;
		}
		
		override public function created():void
		{
			_txt = new MultiLineTextField(
				"",
				{ width: stage.stageWidth, height: stage.stageHeight },
				{ color: 0x666666, font: "Courier", size: 14 } );
			
			addChild( _txt );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function code( event:RslEvent ):void
		{
			showLoadProgress( "code", event );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function configuration( event:RslEvent ):void
		{
			showLoadProgress( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function rsl( event:RslEvent ):void
		{
			showLoadProgress( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function font( event:RslEvent ):void
		{
			showLoadProgress( event.preloader.phase, event );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function complete( event:RslEvent ):void
		{
			setText( "ready." );
		}
		
		private function showLoadProgress(
			message:String,
			event:RslEvent = null ):void
		{
			var output:String = message;
			
			if( event )
			{
				output += " " + event.normalized * 100
					+ "% (" + event.bytesLoaded + "/" + event.bytesTotal + ") ["
					+ event.type + "] " + event.name;
			}
			
			trace( output );
			setText( output );
		}
		
		/**
		* 	@private
		*/
		private function setText( text:String ):void
		{
			_txt.appendText( text + "\n" );
			_txt.scrollV = _txt.maxScrollV;
		}
	}
}