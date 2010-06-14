package com.ffsys.swat.as3.view {
	
	import flash.text.*;
	
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
		
		private var _txt:TextField;
		
		/**
		*	Creates a <code>SwatActionscriptApplicationPreloadView</code> instance.
		*/
		public function SwatActionscriptApplicationPreloadView()
		{
			super();
		}
		
		override public function created():void
		{
			_txt = createTextField( "", stage.stageWidth, stage.stageHeight );
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
			showLoadProgress( "complete", event );
			setText( "ready." );
		}		
		
		/**
		* 	@private
		*/
		private function createTextField(
			text:String = "",
			width:Number = 300,
			height:Number = 80,
			font:String = "Courier",
			size:Number = 14,
			color:Number = 0x666666 ):TextField
		{
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.size = size;
			format.color = color;
			format.align = TextFormatAlign.LEFT;
			format.leading = 0;

			var txt:TextField = new TextField();
			txt.width = width;
			txt.height = height;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.defaultTextFormat = format;
			txt.embedFonts = false;
			txt.text = text;
			txt.selectable = false;
			txt.wordWrap = true;

			return txt;
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