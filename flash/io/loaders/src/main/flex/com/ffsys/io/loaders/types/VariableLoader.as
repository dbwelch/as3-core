package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.VariableResource;
	
	/**
	*	Loads <code>URL</code> encoded variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class VariableLoader extends AbstractLoader {
		
		/**
		* 	Creates a <code>VariableLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function VariableLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.VARIABLES;
		}	
		
		/**
		* 	@inheritDoc
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var vars:URLVariables;
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{
					vars = new URLVariables( loader.data );
					super.completeHandler( event, vars );
				}
				
			}else{
				vars = data as URLVariables;
			}
			
			if( vars )
			{
				resource = new VariableResource( vars, uri );
				
				var evt:LoadEvent =
					new LoadEvent(
						LoadEvent.DATA,
						event,
						this,
						resource as VariableResource
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