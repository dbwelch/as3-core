package com.ffsys.dom.core
{
	import org.w3c.dom.*;
		
	/**
	*	Represents a comment.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class CommentImpl extends CharacterDataImpl
		implements Comment
	{
		/**
		* 	Creates a <code>CommentImpl</code> instance.
		*/
		public function CommentImpl( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.COMMENT_NODE;
		}
	}
}