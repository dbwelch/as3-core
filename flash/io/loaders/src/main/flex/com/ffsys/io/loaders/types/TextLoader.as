package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.IResource;	
	import com.ffsys.io.loaders.resources.ObjectResource;
	import com.ffsys.io.loaders.resources.TextResource;
	
	/**
	*	Loads a text file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class TextLoader extends AbstractLoader {
		
		/**
		* 	Creates a <code>TextLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function TextLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}
		
		/**
		*	Parses the loaded text data to an object.
		* 
		* 	The default implementation does nothing.
		*	
		*	@param text The loaded text data.
		*	
		*	@return An object parsed from the text.
		*/
		protected function parse( text:String ):Object
		{
			return null;
		}
		
		/**
		* 	Determines whether the loaded text should be parsed.
		* 
		* 	@return A boolean indicating whether the loaded text should
		* 	be parsed.
		*/
		protected function shouldParseText():Boolean
		{
			return false;
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
			
			if( txt )
			{
				if( !shouldParseText() )
				{
					this.resource = new TextResource( txt, uri );
				}else{
					this.resource = new ObjectResource( parse( txt ), uri );
				}
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource
				);
				
				super.completeHandler( event, IResource( this.resource ).data );
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
        }
	}
}