package javax.script.scanner
{
	/**
	*	Represents a token that opens and closes
	* 	a block.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	dynamic public class BlockToken extends Token
	{
		private var _start:RegExp;
		private var _end:RegExp;
		private var _open:Boolean;
		private var _parent:Object;
		private var _required:Boolean = false;
		
		/**
		* 	Creates a <code>BlockToken</code> instance.
		* 
		* 	@param id The identifier for the token.
		* 	@param start The start expression for the block.
		* 	@param end The end expression for the block.
		*/
		public function BlockToken(
			id:int = 0,
			//name:String = null,		//TODO
			source:Object = null,
			start:RegExp = null,
			end:RegExp = null )
		{
			super( id, source );
			this.start = start;
			this.end = end;
		}
		
		/**
		* 	Determines whether this block must be specified
		* 	for the associated token to match.
		* 
		* 	The default value is <code>false</code>.
		*/
		public function get required():Boolean
		{
			return _required;
		}
		
		public function set required( value:Boolean ):void
		{
			_required = value;
		}
		
		/**
		* 	Used to store a reference to the current
		* 	object prior to opening this block.
		*/
		internal function get parent():Object
		{
			return _parent;
		}
		
		internal function set parent( value:Object ):void
		{
			_parent = value;
		}
		
		/**
		* 	Indicates whether this block is considered
		* 	to be open, ie, an end match has not yet
		* 	been found for the token.
		*/
		override public function get open():Boolean
		{
			return _open;
		}
		
		public function set open( value:Boolean ):void
		{
			_open = value;
			trace("[OPEN] BlockToken::set open()", name, value );
		}
		
		/**
		* 	A regular expression
		* 	that indicates the start of this block.
		*/
		public function get start():RegExp
		{
			return _start;
		}
		
		public function set start( value:RegExp ):void
		{
			_start = value;
		}
		
		/**
		* 	A regular expression
		* 	that indicates the end of this block.
		*/
		public function get end():RegExp
		{
			return _end;
		}
		
		public function set end( value:RegExp ):void
		{
			_end = value;
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
			output.required = required;
			return output;
		}
	}
}