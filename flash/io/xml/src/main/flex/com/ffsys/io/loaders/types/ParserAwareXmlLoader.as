package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	import com.ffsys.io.loaders.types.XmlLoader;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.ObjectResource;
	
	import com.ffsys.io.xml.IParser;
	
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
	public class ParserAwareXmlLoader extends XmlLoader {
		
		private var _parser:IParser;
		private var _root:Object;
		
		/**
		*	Creates a <code>ParserAwareXmlLoader</code> instance.
		*/
		public function ParserAwareXmlLoader()
		{
			super();
		}
		
		/**
		*	The parser associated with this loader.	
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
		*	A root object that the XML document will be parsed into.
		*	
		*	If this is null then the default root object declared by
		*	the parser will be used.	
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
				
			if( x )
			{
				var parsed:Object = this.parser.deserialize( x, root );
				
				resource = getResource( parsed, uri, bytesTotal );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					ObjectResource( resource ) );
					
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
			
			dispatchLoadCompleteEvent();
        }
	}
}