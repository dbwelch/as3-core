package org.flashx.ui.dom
{
	
	
	dynamic public class Text extends CharacterData
	{
		
		/**
		* 	Creates a <code>Text</code> instance.
		*/
		public function Text( xml:XML = null )
		{
			_nodeType = Node.TEXT_NODE;			
			super( xml );
		}
		
		public function splitText( offset:Number ):Text
		{
			return null;
		}
		
		/*
		
		Object Text
		Text has the all the properties and methods of the CharacterData object as well as the properties and methods defined below.
		The Text object has the following methods:
		splitText(offset)
		This method returns a Text object.
		The offset parameter is of type Number.
		This method can raise a DOMException object.		
		
		
		*/
	
	}

}

