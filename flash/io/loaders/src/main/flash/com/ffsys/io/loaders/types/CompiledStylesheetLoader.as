package com.ffsys.io.loaders.types {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.utils.flex.FlexUtils;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	import com.ffsys.io.loaders.core.LoaderClassType;
	
	import com.ffsys.io.loaders.events.CompiledStylesheetLoadEvent;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Represents a loader for compiled runtime CSS swf movies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class CompiledStylesheetLoader extends AbstractLoader {
		
		public function CompiledStylesheetLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		override public function get type():String
		{
			return LoaderClassType.COMPILED_CSS_TYPE;
		}
		
		//--? should CompiledStylesheetLoader have a resource set
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var evt:CompiledStylesheetLoadEvent = new CompiledStylesheetLoadEvent( event, this );
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
			
			dispatchLoadCompleteEvent();
        }
				
	}
	
}
