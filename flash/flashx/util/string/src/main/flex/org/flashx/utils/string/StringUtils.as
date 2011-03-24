package org.flashx.utils.string {
	
	import org.flashx.utils.string.StringConstants;
	
	import org.flashx.utils.string.StringFormatter;
	import org.flashx.utils.string.StringHelper;
	import org.flashx.utils.string.StringPad;
	import org.flashx.utils.string.StringRepeater;
	import org.flashx.utils.string.StringStrip;
	import org.flashx.utils.string.StringSubstitutor;
	import org.flashx.utils.string.StringTrim;
	
	import org.flashx.utils.string.ClassStringUtils;
	
	/**
	*	Utility methods for working
	*	with <code>String</code> instances.
	*	
	*	@see com.ffsys.utils.string.StringConstants
	*	@see com.ffsys.utils.string.StringFormatter
	*	@see com.ffsys.utils.string.StringHelper
	*	@see com.ffsys.utils.string.StringPad
	*	@see com.ffsys.utils.string.StringRepeater
	*	@see com.ffsys.utils.string.StringStrip
	*	@see com.ffsys.utils.string.StringSubstitutor
	*	@see com.ffsys.utils.string.StringTrim
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2007
	*/
	public class StringUtils extends Object {
		
		/*
		*	StringConstants shortcuts - will be deprecated.
		*/
		
		static public const ESCAPE:String = 
			StringConstants.ESCAPE;
		
		static public const URI_DELIMITER:String =
			StringConstants.URI_DELIMITER;
		
		static public const NEWLINE:String =
			StringConstants.NEWLINE;
		
		static public const TAB:String =
			StringConstants.TAB;

		static public const HYPHEN:String =
			StringConstants.HYPHEN;
		
		static public const UNDERSCORE:String =
			StringConstants.UNDERSCORE;
		
		static public const HASH:String =
			StringConstants.HASH;
		
		static public const ASTERISK:String =
			StringConstants.ASTERISK;
				
		static public const SPACE:String =
			StringConstants.SPACE;
		
		static public const DOT:String =
			StringConstants.DOT;
		
		static public const COMMA:String =
			StringConstants.COMMA;
		
		static public const LEFT_BRACE:String =
			StringConstants.LEFT_BRACE;
			
		static public const RIGHT_BRACE:String =
			StringConstants.RIGHT_BRACE;

		static public const INDENT:String =
			StringConstants.INDENT;
		
		public function StringUtils()
		{
			super();
		}
		
		/*
		*	StringRepeater	
		*/
		
		/**
		*	@see com.ffsys.utils.string.StringRepeater
		*/
		static public function repeat(
			source:String,
			length:int ):String
		{
			var repeater:StringRepeater = new StringRepeater();
			return repeater.repeat( source, length );
		}
		
		/*
		*	StringSubstitutor	
		*/
		
		/**
		*	@see com.ffsys.utils.string.StringSubstitutor
		*/
		static public function substitute( source:String, ...args ):String
		{
			var substitutor:StringSubstitutor = 
				new StringSubstitutor();
			return substitutor.replace( source, args );
		}				
		
		/*
		*	StringStrip	
		*/		
		
		/**
		*	@see com.ffsys.utils.string.StringStrip
		*/
		static public function lstrip(
			source:String = "",
			search:String = "" ):String
		{
			var stripper:StringStrip = new StringStrip();
			return stripper.lstrip( source, search );
		}
		
		/**
		*	@see com.ffsys.utils.string.StringStrip
		*/
		static public function rstrip(
			source:String = "",
			search:String = "" ):String
		{
			var stripper:StringStrip = new StringStrip();
			return stripper.rstrip( source, search );			
		}
		
		/**
		*	@see com.ffsys.utils.string.StringStrip
		*/		
		static public function strip(
			source:String = "",
			search:String = "" ):String
		{
			var stripper:StringStrip = new StringStrip();
			return stripper.strip( source, search );
		}
		
		/*
		*	StringTrim	
		*/
		
		/**
		*	@see com.ffsys.utils.string.StringTrim
		*/		
		static public function ltrim( source:String = "" ):String
		{
			var trimmer:StringTrim = new StringTrim( source );
			return trimmer.ltrim();
		}
		
		/**
		*	@see com.ffsys.utils.string.StringTrim
		*/		
		static public function rtrim( source:String ):String
		{
			var trimmer:StringTrim = new StringTrim( source );
			return trimmer.rtrim();			
		}
		
		/**
		*	@see com.ffsys.utils.string.StringTrim
		*/		
		static public function trim( source:String ):String
		{
			var trimmer:StringTrim = new StringTrim( source );
			return trimmer.trim();		
		}
		
		/*
		*	ClassStringUtils	
		*/
		
		/**
		*	@see com.ffsys.utils.ClassStringUtils
		*/		
		static public function parsePackageName( source:String = "" ):String
		{
			return ClassStringUtils.parsePackageName( source );
		}
		
		/**
		*	@see com.ffsys.utils.ClassStringUtils
		*/		
		static public function parseClassName( source:String = "" ):String
		{
			return ClassStringUtils.parseClassName( source );			
		}
		
		/**
		*	@see com.ffsys.utils.ClassStringUtils
		*/		
		static public function getClassString( source:String = "" ):String
		{
			return ClassStringUtils.getClassString( source );
		}
		
		/*
		*	AddressUtils	
		*/
		
		/**
		*	@see com.ffsys.utils.AddressUtils	
		*/
		static public function basename(
			source:String = "",
			stripExtension:Boolean = false ):String
		{
			return AddressUtils.basename( source, stripExtension );
		}
		
		/**
		*	@see com.ffsys.utils.AddressUtils	
		*/
		static public function getExtension(
			source:String = "" ):String
		{
			return AddressUtils.getExtension( source );
		}
		
		/**
		*	@see com.ffsys.utils.AddressUtils
		*/
		static public function removeExtension(
			source:String = "" ):String
		{
			return AddressUtils.removeExtension( source );
		}
		
		/*
		*	StringHelper	
		*/
		
		/**
		*	@see com.ffsys.utils.string.StringHelper
		*/
		static public function words(
			source:String = "" ):Array
		{
			var helper:StringHelper = new StringHelper();
			return helper.words( source );
		}
		
		/*
		*	StringFormatter	
		*/
		
		/**
		*	@see com.ffsys.utils.string.StringFormatter
		*/
		static public function firstCharToLowerCase(
			source:String = "" ):String
		{
			var formatter:StringFormatter = new StringFormatter();
			return formatter.firstCharToLowerCase( source );
		}
		
		/**
		*	@see com.ffsys.utils.string.StringFormatter
		*/
		static public function firstCharToUpperCase(
			source:String = "" ):String
		{
			var formatter:StringFormatter = new StringFormatter();
			return formatter.firstCharToUpperCase( source );
		}
		
		/**
		*	@see com.ffsys.utils.string.StringFormatter
		*/
		static public function toTitleCase( source:String = "" ):String
		{
			var formatter:StringFormatter = new StringFormatter();
			return formatter.toTitleCase( source );
		}
		
		/*
		*	StringPad
		*/
		
		static public function padLines(
			source:String,
			padding:String,
			stripLeadingWhiteSpace:Boolean = false,
			stripTrailingWhiteSpace:Boolean = false ):String
		{
			var padder:StringPad = new StringPad();
			return padder.padLines(
				source,
				padding,
				stripLeadingWhiteSpace,
				stripTrailingWhiteSpace );
			
			/*
			lines = lines.replace( /\n$/, "" );
			
			var output:String = "";
			var arr:Array = lines.split( NEWLINE );
			
			var i:int = 0;
			var l:int = arr.length;
			
			
			if( l == 1 )
			{
				return padding + lines;
			}
			
			var line:String;
			
			for( ;i < l;i++ )
			{
				line = arr[ i ];
				
				if( stripLeadingWhiteSpace )
				{
					line = ltrim( line );
				}
				
				if( stripTrailingWhiteSpace )
				{
					line = rtrim( line );
				}
				
				line = padding + line;
				
				if( i < ( l - 1 ) )
				{
					line += NEWLINE;
				}
				
				output += line;
			}
			
			return output;
			*/
		}
		
		//-->
		
		static public function formatToDivisorString(
			total:uint = 0,
			divisor:Number = 0,
			suffixes:Array = null,
			delimiter:String = null,
			suffixDelimiter:String = null ):String
		{
			
			if( !delimiter )
			{
				delimiter = SPACE;
			}
			
			if( !suffixDelimiter )
			{
				suffixDelimiter = SPACE;
			}
			
			var values:Array = new Array();
			
			var factor:uint;
			var amount:uint;
			
			var i:int = 0;
			var l:int = suffixes.length;
			
			for( ;i < l;i++ )
			{
				factor = Math.pow( divisor, ( i + 1 ) );
				
				amount = total / factor;
				
				if( amount < 1 )
				{
					break;
				}
				
				if( i )
				{
					values[ i - 1 ] =
						( total % factor ) / Math.pow( divisor, ( i ) );
				}
				
				values.push( amount );
				
			}
			
			for( i = 0;i < values.length;i++ )
			{
				values[ i ] = values[ i ] + suffixDelimiter + suffixes[ i ];
			}
			
			values.reverse();
			
			return values.join( delimiter );			
		}
			
	}	
}