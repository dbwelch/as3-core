package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.PropertiesResource;
	
	import com.ffsys.utils.properties.IProperties;	
	
	/**
	*	Loads a properties file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class PropertiesLoader extends AbstractLoader {
		
		private var _properties:IProperties;
		
		/**
		* 	Creates a <code>PropertiesLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function PropertiesLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
		/**
		* 	A properties implementation to use to parse the loaded
		* 	text.
		*/
		public function get properties():IProperties
		{
			return _properties;
		}
		
		public function set properties( value:IProperties ):void
		{
			_properties = value;
		}		
		
		/**
		* 	@inheritDoc
		*/
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
				}
			}else{
				txt = data as String;
			}
			
			var evt:LoadEvent = null;
			
			if( txt )
			{
				this.resource = new PropertiesResource(
					txt,
					uri,
					this.bytesTotal,
					this.properties );
				
				evt = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource
				);

				super.completeHandler( event, PropertiesResource( this.resource ).properties );
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