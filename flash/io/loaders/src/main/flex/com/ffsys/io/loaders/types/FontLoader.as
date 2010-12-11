package com.ffsys.io.loaders.types {
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;	
	import flash.text.Font;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractDisplayLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.FontResource;
	
	/**
	*	Loads flash movies containing embedded fonts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class FontLoader extends AbstractDisplayLoader {
		
		/**
		* 	Creates a <code>FontLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function FontLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			
			//force fonts to be trusted by default
			this.context = new LoaderContext(
				false, ApplicationDomain.currentDomain );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		/**
		* 	@inheritDoc
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			this.resource = new FontResource(
				loader, uri, bytesTotal );
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.DATA,
				event,
				this,
				resource as FontResource
			);
			
			initializeFonts( _loader );
			
			super.completeHandler( event );
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );

			//clean our reference to the underlying Loader
			_loader = null;
        }
		
		/**
		*	@private	
		*/
		private function initializeFonts( loader:Loader ):void
		{
			var application:Sprite = getFontApplication( loader );
			var type:XML = null;
			var clazz:Class = null;
			if( application )
			{	
				var name:String = getQualifiedClassName( application );
				
				try
				{
					clazz = getDefinitionByName( name ) as Class;
				}catch( e:Error )
				{
					//fail silently if we can't extract the class reference
					//for the root of the loaded swf file, this may happen
					//if the loader context has been changed from the default
					//trusted value
					
					//throw e;
				}
				
				if( clazz )
				{
					type = describeType( clazz );
					var list:XMLList = type..variable;
					var x:XML = null;
					var re:RegExp = new RegExp( "FontClass$" );
					for each( x in list )
					{
						if( re.test( x.@name ) && x.@type == "Class" )
						{
							var value:Class = Class( clazz[ x.@name ] );
							if( value )
							{
								Font.registerFont( value );
							}
						}
					}
				}
			}
		}
		
		/**
		*	@private	
		*/		
		private function getFontApplication( loader:Loader ):Sprite
		{
			if( loader &&
			 	loader.content &&
				( loader.content is Sprite ) )	//catches AVM1 Movies, where the cast below will fail
			{
				return Sprite( loader.content );
			}
			
			return null;
		}
	}
}