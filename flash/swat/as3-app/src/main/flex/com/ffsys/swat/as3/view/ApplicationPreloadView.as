package com.ffsys.swat.as3.view {
	
	import flash.text.*;
	
	import com.ffsys.ui.text.core.MultiLineTextField;	
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.view.DefaultApplicationPreloadView;
	
	/**
	*	Custom application preload view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class ApplicationPreloadView extends DefaultApplicationPreloadView {
		
		private var _txt:MultiLineTextField;
		
		/**
		*	Creates a <code>ApplicationPreloadView</code> instance.
		*/
		public function ApplicationPreloadView()
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
		* 	@private
		*/
		override protected function debug( phase:String, event:RslEvent ):String
		{
			var msg:String = super.debug( phase, event );
			showLoadProgress( msg );
			return msg;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function finished( event:RslEvent ):void
		{
			setText( "ready." );
		}
		
		private function showLoadProgress(
			message:String ):void
		{
			var output:String = message;
			setText( output );
		}
		
		/**
		* 	@private
		*/
		private function setText( text:String ):void
		{
			_txt.appendText( text + "\n" );
			if( _txt.height > stage.stageHeight )
			{
				_txt.y = ( stage.stageHeight - _txt.height );
			}
		}
	}
}