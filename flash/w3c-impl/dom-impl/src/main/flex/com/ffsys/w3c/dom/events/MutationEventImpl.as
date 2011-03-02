package com.ffsys.w3c.dom.events
{
	import org.w3c.dom.Node;
	import org.w3c.dom.events.MutationEvent;

	/**
	* 	Represents a user interface event.
	*/
	public class MutationEventImpl extends EventImpl
		implements MutationEvent
	{
		/**
		* 	Represents a modification.
		*/
		public static const MODIFICATION:int = 1;
		
		/**
		* 	Represents an addition.
		*/
		public static const ADDITION:int = 2;
		
		/**
		* 	Represents a removal.
		*/
		public static const REMOVAL:int = 3;

		/**
		* 	An attribute modified event type.
		*/
		public static const DOM_ATTR_MODIFIED:String = "DOMAttrModified";

		/**
		* 	A character data modified event type.
		*/
		public static const DOM_CHARACTER_DATA_MODIFIED:String = "DOMCharacterDataModified";
		
		//DOMNodeInserted
		//DOMNodeInsertedIntoDocument
		//DOMNodeRemoved
		//DOMNodeRemovedFromDocument
		//DOMSubtreeModified
		
		private var _relatedNode:Node;
		private var _prevValue:String;
		private var _newValue:String;
		private var _attrName:String;
		private var _attrChange:int;

		/**
		* 	Creates a <code>MutationEventImpl</code> instance.
		* 
		* 	@param type The type of the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is cancelable.
		*/
		public function MutationEventImpl(
			type:String = null,
			bubbles:Boolean = false,
			cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		/**
		* 	A node related to the mutation.
		*/
		public function get relatedNode():Node
		{
			return _relatedNode;
		}
		
		/**
		* 	A previous value.
		*/
		public function get prevValue():String
		{
			return _prevValue;
		}
		
		/**
		* 	A new value.
		*/
		public function get newValue():String
		{
			return _newValue;
		}
		
		/**
		* 	An attribute name.
		*/
		public function get attrName():String
		{
			return _attrName;
		}
		
		/**
		* 	An attribute change detail.
		*/
		public function get attrChange():int
		{
			return _attrChange;
		}
		
		/**
		* 	Initializes a mutation event.
		* 
		* 	@param type The type for the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is
		* 	cancelable.
		* 	@param relatedNode A related node.
		* 	@param prevValue A previous value.
		* 	@param newValue A new value.
		* 	@param attrName An attribute name.
		* 	@param attrChange An attribute change detail.
		*/
		public function initMutationEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			relatedNode:Node,
			prevValue:String,
			newValue:String,
			attrName:String,
			attrChange:int ):void
		{
			initEvent( type, bubbles, cancelable );
			_relatedNode = relatedNode;
			_prevValue = prevValue;
			_newValue = newValue;
			_attrName = attrName;
			_attrChange = attrChange;
		}
	}
}