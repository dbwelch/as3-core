package org.flashx.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.flashx.events.Notifier;
	
	import org.flashx.io.loaders.core.AbstractLoader;
	import org.flashx.io.loaders.core.LoadOptions;
	
	import org.flashx.io.loaders.events.LoadEvent;
	
	import org.flashx.io.loaders.core.ILoadOptions;
	
	import org.flashx.io.loaders.types.XmlLoader;
	import org.flashx.io.loaders.resources.IResource;
	import org.flashx.io.loaders.resources.ObjectResource;
	
	import org.flashx.io.xml.IParser;
	
	/**
	*	A loader that loads an XML document and parses
	*	it into an object graph using a parser associated with
	*	this loader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.10.2010
	*/
	public class ParserAwareXmlLoader extends XmlLoader
		implements IParserAwareXmlLoader {
		
		private var _parser:IParser;
		private var _root:Object;
		
		/**
		*	Creates a <code>ParserAwareXmlLoader</code> instance.
		*/
		public function ParserAwareXmlLoader(
			request:URLRequest = null,
			options:ILoadOptions = null	)
		{
			super( request, options );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get parser():IParser
		{
			return _parser;
		}
		
		public function set parser( parser:IParser ):void
		{
			_parser = parser;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get root():Object
		{
			return _root;
		}
		
		public function set root( root:Object ):void
		{
			_root = root;
		}
		
		/**
		*	Gets the type of resource to instantiate and associate
		*	with this loader.
		*	
		*	This allows sub-classes to define type-safe resource
		*	classes and return them here. Preventing the need to 
		*	cast the object that the resource encapsulates.
		*	
		*	@param data The data for the resource.
		*	@param uri The URI the resource was loaded from.
		*	@param bytesTotal The total number of bytes for the resource.
		*/
		protected function getResource(
			data:Object, uri:String, bytesTotal:uint ):ObjectResource
		{
			return new ObjectResource( data, uri, bytesTotal );
		}
		
		/**
		*	@inheritDoc	
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var x:XML;
			
			if( !parser )
			{
				throw new Error(
					"Cannot handle a loaded XML resource with no associated parser." );
			}
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{
					x = new XML( loader.data );
				}
			}else{
				x = data as XML;
			}
			
			var evt:LoadEvent = null;
				
			if( x )
			{
				//trace("ParserAwareXmlLoader::deserialize(), ", root );
				var parsed:Object = this.parser.deserialize( x, root );

				this.resource = getResource( parsed, uri, bytesTotal );
				
				evt = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					ObjectResource( resource ) );
				
				dispatchEvent( evt );	
				Notifier.dispatchEvent( evt );
				
				//we've created the resource
				//clean our data reference
				data = null;
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