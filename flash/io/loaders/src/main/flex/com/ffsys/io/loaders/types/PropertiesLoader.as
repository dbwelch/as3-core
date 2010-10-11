package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.PropertiesResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Loads data from a properties file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class PropertiesLoader extends AbstractLoader {
		
		public function PropertiesLoader(
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
				resource = new PropertiesResource( txt, uri );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as PropertiesResource
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