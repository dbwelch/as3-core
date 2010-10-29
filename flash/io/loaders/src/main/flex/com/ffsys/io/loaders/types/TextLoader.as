package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.TextResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Encapsulates loading plain text data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class TextLoader extends AbstractLoader {
		
		public function TextLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var txt:String;
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{				
					txt = new String( loader.data );
					super.completeHandler( event, txt );
				}
			}else{
				txt = data as String;
			}
			
			if( txt )
			{
				resource = new TextResource( txt, uri );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as TextResource
				);
					
				if( queue )
				{
					queue.addResource( this );
				}
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
			}
			
			//dispatchLoadCompleteEvent();
        }
	}
}