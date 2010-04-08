package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.types.IXmlAccess;
	import com.ffsys.io.loaders.resources.XmlResource;
	
	/**
	*	Event dispatched when an <code>XML</code>
	*	document has been loaded and parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class XmlLoadEvent extends LoadEvent
		implements IXmlAccess {
		
		public function XmlLoadEvent(
			event:Event,
			loader:ILoader,
			resource:XmlResource )
		{
			super( LoadEvent.DATA, event, loader, resource );
		}
		
		public function get xml():XML
		{
			return XmlResource( this.resource ).xml;
		}
		
		override public function clone():Event
		{
			return new XmlLoadEvent(
				triggerEvent, loader, XmlResource( this.resource ) );
		}
	}
}