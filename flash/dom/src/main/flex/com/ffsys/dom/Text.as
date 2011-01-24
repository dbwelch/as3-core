package com.ffsys.dom
{
	
	
	dynamic public class Text extends CharacterData
	{
		/**
		* 	Creates a <code>Text</code> instance.
		*/
		public function Text( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.TEXT_NODE;
		}
		
		public function splitText( offset:Number ):Text
		{
			//This method can raise a DOMException object.
			//TODO: create a text element from the document
			return null;
		}
	}
}