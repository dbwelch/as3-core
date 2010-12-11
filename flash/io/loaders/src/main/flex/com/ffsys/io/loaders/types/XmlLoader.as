package com.ffsys.io.loaders.types {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.XmlResource;
	
	/**
	*	Loads an <code>XML</code> file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class XmlLoader extends AbstractLoader {
		
		/**
		* 	Creates an <code>XmlLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function XmlLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
		/**
		*	@inheritDoc	
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var x:XML;
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{
					x = new XML( loader.data );	
					super.completeHandler( event, x );
				}
			}else{
				x = data as XML;
			}
				
			if( x )
			{
				resource = new XmlResource( x, uri );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this, 
					resource as XmlResource );
					
				if( queue )
				{
					queue.addResource( this );
				}
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
				
				//we've created the resource
				//clean our data reference
				data = null;
			}
			
			//dispatchLoadCompleteEvent();
        }
	}
}