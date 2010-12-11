package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.StyleSheetResource;
	
	/**
	*	Loads a css text file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class StyleSheetLoader extends AbstractLoader {
		
		/**
		* 	Creates a <code>StyleSheetLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function StyleSheetLoader(	
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
		/**
		*	Parses the loaded text data to a style sheet.
		*	
		*	@param text The loaded css text data.
		*	
		*	@return The style sheet the text was parsed into.
		*/
		protected function parse( text:String ):StyleSheet
		{
			var sheet:StyleSheet = new StyleSheet();
			sheet.parseCSS( text );
			return sheet;
		}
		
		/**
		*	Gets an instance of the style sheet to parse
		*	the loaded text data into.	
		*/
		protected function getStyleSheet():StyleSheet
		{
			return new StyleSheet();
		}
		
		/**
		*	@inheritDoc	
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var loader:URLLoader = URLLoader( event.target );
			var sheet:StyleSheet = parse( String( loader.data ) );
			if( sheet )
			{
				resource = new StyleSheetResource( sheet, uri );
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as StyleSheetResource
				);
				
				//TODO: refactor
				if( queue )
				{
					queue.addResource( this );
				}
				
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
        }
	}
}