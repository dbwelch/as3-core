package com.ffsys.ui.dom
{
	
	/**
	*	Represents a comment element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class Comment extends CharacterData
	{
		
		/**
		* 	Creates a <code>Comment</code> instance.
		*/
		public function Comment( xml:XML = null )
		{
			_nodeType = Node.COMMENT_NODE;
			super( xml );
		}
	
		/*
	
		Object Comment
		Comment has the all the properties and methods of the CharacterData object as well as the properties and methods defined below.	
	
		*/
	}
}