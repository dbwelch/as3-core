package org.flashx.utils.string {
	
	/**
	*	Utility methods for working with
	*	<code>String</code> addresses.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.06.2007
	*/
	public class AddressUtils extends Object {
		
		/**
		*	The delimter to use when building
		*	URI style addresses.
		*/
		static public const DELIMITER:String = "/";
		
		/**
		*	The query string start character.
		*/
		static public var QUERY:String = "?";
	
		/**
		*	The query string delimiter character.
		*/
		static public var QUERY_DELIMITER:String = "&";		
		
		/**
		*	The delimiter between a protocol specifier and the rest of the URI.
		*/
		static public const PROTOCOL_DELIMITER:String =
			":" + DELIMITER + DELIMITER;
		
		/**
		*	The URI fragment identifier that denotes a location on a page.
		*/
		static public const FRAGMENT_IDENTIFIER:String =
			"#";
		
		/**
		*	The HTTP protocol.
		*/
		static public const HTTP_PROTOCOL:String =
			"http";
		
		/**
		*	The HTTPS protocol.
		*/
		static public const HTTPS_PROTOCOL:String =
			"https";
		
		/**
		*	The FTP protocol.
		*/
		static public const FTP_PROTOCOL:String =
			"ftp";
		
		/**
		*	The FILE protocol.
		*/
		static public const FILE_PROTOCOL:String =
			"file";
		
		/**
		*	An array of all recognised protocols including the protocol delimiter.
		*/
		static public const PROTOCOLS:Array = [
			HTTP_PROTOCOL + PROTOCOL_DELIMITER,
			HTTPS_PROTOCOL + PROTOCOL_DELIMITER,
			FTP_PROTOCOL + PROTOCOL_DELIMITER,
			FILE_PROTOCOL + PROTOCOL_DELIMITER
		];
		
		static public const PROTOCOL_REGEXP:RegExp =
			new RegExp( "^([a-zA-Z]+)" + PROTOCOL_DELIMITER + "(.*)" );
		
		/**
		*	@private
		*/
		public function AddressUtils()
		{
			super();
		}
		
		/**
		*	Concatenates one URI portion with another.
		*
		*	@param base the base URI to be concatenated to
		*	@param relative the String URI to be concatenated
		*	@param trailingSlash a Boolean indicating whether a trailing slash should be appended
		*
		*	@return the concatenated String URI
		*/
		static public function concatenate(
			base:String,
			relative:String,
			trailingSlash:Boolean = false ):String
		{
			//remove any trailing slashes from the base and whitespace
			base = base.replace( new RegExp( "\\s+$" ), "" );
			base = base.replace( new RegExp( "^\\s+" ), "" );
			base = base.replace( new RegExp( "/*$" ), "" );
			
			//remove any leading slashes from the relative portion
			
			relative = relative.replace( /^\/+/, "" );
			relative = relative.replace( /\/+$/, "" );
			
			if( base.length > 0 )
			{
				//add the single slash delimiter
				base += AddressUtils.DELIMITER;
			}
			
			//only add a trailing slash if there is no file extension
			//and no existing trailing slash
			if( trailingSlash
				&& !relative.match( /\.[a-zA-Z0-9]+|\/$/ ) )
			{
				relative += AddressUtils.DELIMITER;
			}
			
			if( !trailingSlash )
			{
				relative = relative.replace( /\/$/, "" );
			}
			
			var output:String = base + relative;
			
			//remove any double slashes
			output = output.replace( /([^:])\/\//g, "$1" + AddressUtils.DELIMITER );

			return output;
		}		
		
		/**
		*	Determines whether a given String begins with a 
		*	recognised protocol.
		*
		*/
		static public function beginsWithProtocol( source:String ):Boolean
		{
			var i:int = 0;
			var l:int = PROTOCOLS.length;
			
			for( ;i < l;i++ )
			{
				if( source.indexOf( PROTOCOLS[ i ] ) == 0 )
				{
					return true;
				}
			}
			
			return false;
		}
		
		static public function hasProtocol( source:String ):Boolean
		{
			var matches:Array = source.match( PROTOCOL_REGEXP );
			return matches && matches.length;
		}
		
		static public function getProtocol( source:String ):String
		{
			if( !source )
			{
				return "";
			}
			
			source = source.replace( PROTOCOL_REGEXP, "$1" );
			return source;
		}
		
		static public function getDomain(
			address:String,
			omitProtocol:Boolean = false ):String
		{
			if( !beginsWithProtocol( address ) )
			{
				return address;
			}
			
			var re:RegExp = new RegExp( "((" + PROTOCOLS.join( "|" ) + ")[^/]+)/?.*$" );
			
			//trace( "Reg Exp : " + re );
			
			var output:String = address.replace( re, "$1" );
			
			//trace( "getDomain : " + output );
			
			if( omitProtocol )
			{
				output = output.replace( /^[a-zA-Z]+:\/\//, "" );
			}
			
			return output;
		}
		
		static public function equals( source:String = "", compare:String = "" ):Boolean
		{
			source = stripSlashes( source );
			compare = stripSlashes( compare );
			
			return ( source == compare );	
		}
		
		static public function exists( source:String = "", compare:String = "" ):Boolean
		{
			source = stripSlashes( source );
			compare = stripSlashes( compare );
			
			if( compare.length > source.length )
			{
				return false;
			}
			
			return ( source.indexOf( compare ) == 0 );
		}
		
		static public function stripLeadingSlashes( source:String ):String
		{
			return StringUtils.lstrip( source, DELIMITER );
		}
		
		static public function stripTrailingSlashes( source:String ):String
		{
			return StringUtils.rstrip( source, DELIMITER );
		}
		
		static public function stripSlashes( source:String ):String
		{
			source = stripLeadingSlashes( source );
			source = stripTrailingSlashes( source );
			return source;
		}
		
		static public function stripQueryString( source:String ):String
		{
			if( !source )
			{
				return "";
			}
			
			return source.replace( /\?.*$/, "" );
		}
		
		static public function basename(
			source:String = "",
			stripExtension:Boolean = false ):String
		{
			source = stripQueryString( source );
			
			//strip any trailing slashes
			source = stripTrailingSlashes( source );
			//source = source.replace( new RegExp( "/*$" ), "" );
			
			//strip an extension/query string if present
			if( stripExtension )
			{
				source = removeExtension( source );
			}
			
			//in case it's a folder reference with a trailing slash
			//source = AddressUtils.stripTrailingSlashes( source );
			
			//now extract the last portion
			return source.substr( source.lastIndexOf( DELIMITER ) + 1 );		
		}
		
		/**
		*	Attempts to get the extension of a given String.
		*
		*	If the String does not contain a dot (period) character
		*	it is returned intact. Otherwise all characters that
		*	appear after the last occurence of a dot character are
		*	returned.
		*
		*	@param the String to extract the extension from
		*
		*	@return the String extension if present or the original String
		*/
		static public function getExtension( source:String = "" ):String
		{
			var ind:int = source.lastIndexOf( "." );
			if( ind != -1 )
			{
				return source.substr( ind + 1 );
			}
			
			return source;
		}
		
		/**
		*	Removes a file extension if found. There is no restriction on
		*	the length of the file extension to remove. Essentially, any
		*	dot (period) character followed by one or more alpha numeric characters
		*	that appears at the end of a String will be removed.
		*
		*	@param str the String to have an extension removed from
		*/
		static public function removeExtension( source:String = "" ):String
		{
			return source.replace( /\.[a-zA-Z0-9]+$/, "" );
		}				
		
		/**
		*
		*	Parses a <code>String</code> representation of an address into an <code>Array</code>.
		*
		*	@param address a <code>String</code> address
		*
		*	@return an <code>Array</code> of the parts of the address
		*/
		static public function parseAddress(
			address:String,
			stripQuery:Boolean = true,
			delimiter:String = null ):Array
		{
			if( !delimiter )
			{
				delimiter = DELIMITER;
			}
			
			address = stripLeadingSlashes( address );
			address = stripTrailingSlashes( address );
			
			if( stripQuery )
			{
				address = stripQueryString( address );
				
				//potentially we still have trailing slashes prior to
				//the removed query string - ensure they are also stripped
				address = stripTrailingSlashes( address );
			}
			
			var arr:Array = address.split( delimiter );
			
			return arr;
		}
		
	}
	
}
