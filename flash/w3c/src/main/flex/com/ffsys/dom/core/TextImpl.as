package com.ffsys.dom.core
{
	import org.w3c.dom.*;
	
	/**
	* 	Represents a text node.
	*/
	dynamic public class TextImpl extends CharacterDataImpl
		implements Text
	{
		/**
		* 	The node name for text nodes.
		*/
		public static const NODE_NAME:String = "#text";
		
		/**
		* 	Creates a <code>TextImpl</code> instance.
		*/
		public function TextImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get isElementContentWhitespace():Boolean
		{
			//TODO
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get wholeText():String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function splitText( offset:Number ):Text
		{
			//This method can raise a DomException object.
			//TODO: create a text element from the document
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function replaceWholeText( content:String ):Text
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.TEXT_NODE;
		}
	}
}