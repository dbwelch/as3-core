package com.ffsys.w3c.dom.events
{
	import org.w3c.dom.DOMException;
	
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	
	
	/**
	* 	Extends the core supported features with the
	* 	Events, MutationEvents and MutationNameEvents features.
	* 
	* 	<ol>
	* 		<li><code>Core</code></li>
	* 		<li><code>ElementTraversal</code></li>
	* 		<li><code>Range</code></li>
	* 		<li><code>Traversal</code></li>
	* 		<li><code>Events</code></li>
	* 		<li><code>MutationEvents</code></li>
	* 		<li><code>MutationNameEvents</code></li>
	* 	</ol>
	*/
	public class DocumentEventImpl extends DOMImplementationImpl
		implements DocumentEvent
	{
		
		/**
		* 	The bean name for the DOM Events implementation.
		*/
		public static const NAME:String = DOMFeature.EVENTS_MODULE;
		
		//TODO: move to org.w3c.events.EventInterfaceType constants
		
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
		* 	@private
		*/
		override protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = super.supported;
				_supported.push( DOMFeature.EVENTS_FEATURE );
				_supported.push( DOMFeature.MUTATION_EVENTS_FEATURE );
				_supported.push( DOMFeature.MUTATION_NAME_EVENTS_FEATURE );
			}
			return _supported;
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