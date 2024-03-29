package org.flashx.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	
	import org.flashx.events.Notifier;
	
	import org.flashx.io.loaders.core.AbstractLoader;
	import org.flashx.io.loaders.core.ILoadOptions;
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.resources.VariableResource;
	
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
				}
			}else{
				vars = data as URLVariables;
			}
			
			var evt:LoadEvent = null;
			
			if( vars )
			{
				this.resource = new VariableResource( vars, uri, bytesTotal );
				
				evt =
					new LoadEvent(
						LoadEvent.DATA,
						event,
						this,
						resource
					);
				
				super.completeHandler( event, vars );
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
			
			evt = new LoadEvent(
				LoadEvent.LOAD_FINISHED,
				event,
				this,
				this.resource
			);
			dispatchEvent( evt );
        }
	}
}