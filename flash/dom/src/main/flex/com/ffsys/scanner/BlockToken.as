package com.ffsys.scanner
{
	/**
	*	Represents a token that opens and closes
	* 	a block.
	* 
	* 	Block tokens may contain child tokens.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	public class BlockToken extends Token
	{
		private var _start:Object;
		private var _end:Object;
		private var _open:Boolean;
		
		/**
		* 	Creates a <code>BlockToken</code> instance.
		* 
		* 	@param id The identifier for the token.
		* 	@param start The start expression for the block.
		* 	@param end The end expression for the block.
		*/
		public function BlockToken(
			id:int = 0,
			start:Object = null,
			end:Object = null,
			match:Object = null )
		{
			super( id, match );
			this.start = start;
			this.end = end;
		}
		
		/**
		* 	Indicates whether this block is considered
		* 	to be open, ie, an end match has not yet
		* 	been found for the token.
		*/
		public function get open():Boolean
		{
			return _open;
		}
		
		public function set open( value:Boolean ):void
		{
			_open = value;
		}
		
		/**
		* 	A string or regular expression
		* 	that indicates the start of this block.
		*/
		public function get start():Object
		{
			return _start;
		}
		
		public function set start( value:Object ):void
		{
			_start = value;
		}
		
		/**
		* 	A string or regular expression
		* 	that indicates the end of this block.
		*/
		public function get end():Object
		{
			return _end;
		}
		
		public function set end( value:Object ):void
		{
			_end = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function test(
			candidate:String, re:RegExp = null ):Boolean
		{
			if( candidate != null )
			{
				if( start is RegExp && start.test( candidate ) ) 
				{
					//trace("Token::test()", "[OPENING TOKEN]", this );
					open = true;
				}
				
				if( end is RegExp && end.test( candidate ) ) 
				{
					open = false;
				}
			}
			return super.test( candidate, re );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function clone( copy:Token = null ):Token
		{
			var output:BlockToken = BlockToken( super.clone(
				new BlockToken( id, match ) ) );
			output.start = start;
			output.end = end;
			output.open = this.open;
			return output;
		}
	}
}