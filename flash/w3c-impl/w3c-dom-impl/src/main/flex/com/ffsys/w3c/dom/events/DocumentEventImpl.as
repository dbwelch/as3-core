package com.ffsys.w3c.dom.events
{
	import org.w3c.dom.DOMException;
	
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;
	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	
	/**
	* 	The default implementation of the document
	* 	event interface for the DOM events module.
	*/
	public class DocumentEventImpl extends AbstractNodeProxyImpl
		implements DocumentEvent
	{
		/**
		* 	Represents the DOM event interface.
		*/
		public static const EVENT_INTERFACE:String = "Event";
		
		/**
		* 	Represents the DOM Mutation event interface.
		*/
		public static const MUTATION_EVENT_INTERFACE:String = "Mutation";
		
		/**
		* 	Represents the DOM Mutation Name event interface.
		*/
		public static const MUTATION_NAME_EVENT_INTERFACE:String = "MutationName";
		
		/**
		* 	Represents the DOM UI event interface.
		*/
		public static const UI_EVENT_INTERFACE:String = "UIEvent";
		
		/**
		* 	Represents the DOM Focus event interface.
		*/
		public static const FOCUS_EVENT_INTERFACE:String = "FocusEvent";
		
		/**
		* 	Represents the DOM Mouse event interface.
		*/
		public static const MOUSE_EVENT_INTERFACE:String = "MouseEvent";
		
		/**
		* 	Represents the DOM Keyboard event interface.
		*/
		public static const KEYBOARD_EVENT_INTERFACE:String = "KeyboardEvent";
		
		/**
		* 	Represents the DOM Text event interface.
		*/
		public static const TEXT_EVENT_INTERFACE:String = "TextEvent";
		
		/**
		* 	Represents the DOM Custom event interface.	
		*/
		public static const CUSTOM_EVENT_INTERFACE:String = "CustomEvent";
		
		/**
		* 	Represents the DOM Composition event interface.
		*/
		public static const COMPOSITION_EVENT_INTERFACE:String = "CompositionEvent";
		
		/**
		* 	Creates a <code>DocumentEventImpl</code> instance.
		*/
		public function DocumentEventImpl()
		{
			super();
		}
		
		/**
		* 	Determines whether this implementation supports
		* 	the specified event interface.
		* 
		* 	@param eventInterface The interface to test for support.
		* 
		* 	@return Whether this implementation supports the specified
		* 	event interface.
		*/
		public function hasInterface( eventInterface:String ):Boolean
		{
			return ( eventInterface === EVENT_INTERFACE
				|| eventInterface === MUTATION_EVENT_INTERFACE
				|| eventInterface === MUTATION_NAME_EVENT_INTERFACE
				|| eventInterface === UI_EVENT_INTERFACE
				|| eventInterface === FOCUS_EVENT_INTERFACE
				|| eventInterface === MOUSE_EVENT_INTERFACE
				|| eventInterface === KEYBOARD_EVENT_INTERFACE
				|| eventInterface === TEXT_EVENT_INTERFACE
				|| eventInterface === CUSTOM_EVENT_INTERFACE
				|| eventInterface === COMPOSITION_EVENT_INTERFACE );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createEvent( eventInterface:String ):DOMEvent
		{
			if( !hasInterface( eventInterface ) )
			{
				throw new DOMException(
					DOMException.UNSUPPORTED_EVENT_INTERFACE_MSG,
					null,
					DOMException.NOT_SUPPORTED_ERR,
					[ eventInterface ] );
			}
			
			var bean:Object = null;
			
			try
			{
				bean = document.getBean( eventInterface );
			}catch( e:Error )
			{
				//document could be null if not instantiated
				//via IoC - requires custom exception
			}
			
			return DOMEvent( bean );
		}
	}
}