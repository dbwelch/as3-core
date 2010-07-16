package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.text.StyleSheet;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.StylesheetResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Represents a loader for CSS stylesheet data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class StylesheetLoader extends AbstractLoader {
		
		public function StylesheetLoader(	
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}		
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
		
			var css:String;
			var sheet:StyleSheet;
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{	
					sheet = new StyleSheet();		
					css = new String( loader.data );
					sheet.parseCSS( css );
					
					super.completeHandler( event, css );
				}
			}else{
				sheet = data as StyleSheet;
			}
			
			if( sheet )
			{
				resource = new StylesheetResource( sheet, uri );			
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as StylesheetResource
				);
				
				if( queue )
				{
					queue.addResource( this );
				}					
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
			}
			
			dispatchLoadCompleteEvent();
        }
	}
}