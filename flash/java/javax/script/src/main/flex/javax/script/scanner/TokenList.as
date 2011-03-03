package javax.script.scanner
{
	/**
	* 	Represents a collection of tokens.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.02.2011
	*/
	dynamic public class TokenList extends Object
	{
		private var _tokens:Vector.<Token>;
		private var _owner:TokenList;
		
		/**
		* 	Creates a <code>TokenList</code> instance.
		*/
		public function TokenList()
		{
			super();
		}
		
		/**
		* 	TODO
		*/
		public function clear():void
		{
			_tokens = new Vector.<Token>();
		}
		
		/**
		* 	The list of tokens this scanner should
		* 	match against.
		* 
		* 	By default tokens are matched in the order
		* 	declared in this list, therefore the token
		* 	at index zero has the highest priority and
		* 	the token at <code>n-1</code> has the lowest
		* 	priority.
		*/
		public function get tokens():Vector.<Token>
		{
			if( _tokens == null )
			{
				_tokens = new Vector.<Token>();
			}
			return _tokens;
		}
		
		public function set tokens( value:Vector.<Token> ):void
		{
			_tokens = value;
		}
		
		/**
		* 	Retrieves a token with the specified identifier.
		* 
		* 	@param id The identifier for the token.
		* 
		* 	@return A token with the specified identifier or
		* 	<code>null</code> if no token could be found.
		*/
		public function getToken( id:int ):Token
		{
			var tkn:Token = null;
			for each( tkn in tokens )
			{
				if( id == tkn.id )
				{
					return tkn;
				}
			}
			return null;
		}
		
		/**
		* 	Retrieves the index of a token.
		* 
		* 	Matching is performed on the token <code>id</code>.
		* 
		* 	@param token The token to search for.
		* 	@param backwards Whether the search is performed
		* 	from the end of the list of match tokens.
		* 	@param start An index to start searching from.
		* 	@param list A specific list of tokens to search, when
		* 	omitted the list of <em>match</em> tokens associated with this scanner
		* 	is searched.
		* 
		* 	@return The index of the match token or -1 if no token
		* 	was found.
		*/
		public function index(
			token:Token,
			backwards:Boolean = false,
			start:int = -1,
			list:Vector.<Token> = null ):int
		{
			if( token != null )
			{
				var id:int = token.id;
				if( list == null )
				{
					list = tokens;
				}
				var i:int = !backwards ? 0 : list.length - 1;
				if( start > -1 )
				{
					//clamp to match list length
					if( start < 0 )
					{
						start = 0;
					}
					if( start >= list.length )
					{
						start = list.length - 1;
					}
					i = start;
				}
				
				var tkn:Token = null;
				while( i >= 0 && i <= ( list.length - 1 ) )
				{
					tkn = list[ i ];
					if( id == tkn.id )
					{
						return i;
					}
					!backwards ? i++ : i--;
				}
			}
			return -1;
		}
		
		/**
		* 	Removes a match token from the list of <code>tokens</code>
		* 	this scanner will match against.
		* 
		* 	Matching is performed against the token <code>id</code>.
		* 
		* 	@param token The token to remove.
		* 
		* 	@return Whether the token was removed.
		*/
		public function removeToken( token:Token, list:Vector.<Token> = null ):Boolean
		{
			if( list == null )
			{
				list = tokens;
			}			
			var index:int = index( token, false, -1, list );
			if( index > -1 )
			{				
				list.splice( index, 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	An owner for this list.
		*/
		public function get owner():TokenList
		{
			return _owner;
		}
		
		/**
		* 	@private
		*/
		internal function setOwner( owner:TokenList ):void
		{
			_owner = owner;
		}
		
		/**
		* 	TODO
		*/
		public function addToken(
			token:Token ):Boolean
		{
			if( token != null )
			{
				token.setOwner( this );
				if( tokens.indexOf( token ) == -1 )
				{
					tokens.push( token );
					return true;
				}
			}
			return false;
		}
	}
}