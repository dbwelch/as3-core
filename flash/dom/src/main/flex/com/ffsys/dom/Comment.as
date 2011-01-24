package com.ffsys.dom
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
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.COMMENT_NODE;
		}
	}
}