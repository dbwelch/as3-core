package com.ffsys.scanner.pattern
{
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.scanner.*;
	
	/**
	* 	Builds scan rules from a string representation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class PatternBuilder extends Object
	{
		private var parentTarget:PatternMatcher = null;
		private var previousParentTarget:PatternMatcher;
		private var current:Pattern = null;
		private var part:Pattern = null;
		
		/**
		* 	Creates a <code>PatternBuilder</code> instance.
		*/
		public function PatternBuilder()
		{
			super();
		}
		
		/**
		* 	Builds a list of scan rules from a string pattern
		* 	representation.
		* 
		* 	@param pattern The string pattern representation.
		* 
		* 	@return A list of scan rules corresponding to the string
		* 	representation.
		*/
		public function build( pattern:String ):PatternMatcher
		{
			var output:PatternMatcher = new PatternMatcher();
			
			current = null;
			
			if( pattern != null )
			{
				trace("[CANDIDATE] PatternBuilder::build()", pattern );
				
				var qualifier:QuantifierPattern = new QuantifierPattern();
				var group:CaptureGroup = new CaptureGroup();				
				
				var prop:String = "(?:[a-zA-Z_]{1}[a-zA-Z0-9_]*)";
				var namedgroup:String = "(?:\\?P<(" + prop + ")>)?";
				var ng:RegExp = new RegExp( "(?:" + namedgroup + ")" );
				var expr:String = "(?:\\[|\\]|\\("
					+ namedgroup + "|\\)|\\{|\\}|\\*|\\||\\+|\\?|\\^|\\$|\\-|\\.)+";
				var re:RegExp = new RegExp(
					//"(\\^)?"
						"(" + expr + ")?([0-9]+)(" + expr + ")?"
					//+ "(\\$)?"
				, "g" );
				var results:Array = re.exec( pattern );
				
				//prepare the string for pattern conversion
				var matches:Vector.<String> = new Vector.<String>();
				var result:String = null;
				var tmp:Array = null;
				var i:uint = 0;
				var k:uint = 0;
				var value:String = null;
				while( results != null )
				{
					tmp = results.slice( 1 );
					for( i = 0;i < tmp.length;i++ )
					{
						value = tmp[ i ] as String;
						if( value != null && value.length > 0 )
						{
							k = value.search( ng );
							if( k > 0 )
							{
								value = value.substr( 0, k );
							}
							
							//split multiple metacharacter sequences
							//into individual meta characters
							if( value.length > 1
								&& isNaN( Number( value ) ) )
							{
								for( k = 0;k < value.length;k++ )
								{
									matches.push( value.charAt( k ) );
								}
							}else
							{
								matches.push( value );
							}
						}
					}
					results = re.exec( pattern );
				}
				
				//build the pattern
				var c:String = null;
				var n:Number = NaN;
				var opens:Boolean = false;
				var closes:Boolean = false;
				var g:PatternGroup = null;
				
				parentTarget = output;
					
				for( i = 0;i < matches.length;i++ )
				{
					c = matches[ i ];
					opens = group.opens( c );
					closes = group.closes( c );
					
					if( opens && parentTarget != null )
					{
						//previousParentTarget = parentTarget;
						current = new CaptureGroup();
						current.matched = c;
						PatternGroup( current ).opens( c );
						CaptureGroup( current ).setOpen( group.open );
						parentTarget.add( current );
						trace("PatternBuilder::build() [OPENING GROUP]", current, current.owner );
						parentTarget = current;
						trace("PatternBuilder::build() [OPENING GROUP NEW PARENT]", parentTarget );
						continue;
					}
					
					if( closes && current is PatternGroup )
					{
						PatternGroup( current ).closes( c );
						//add the close of the group to the group
						part = new CaptureGroup();
						part.matched = c;
						//current.add( part );
						//current = current.owner;
						//parentTarget = current.owner;
						//continue;
					}
					
					n = Number( c );										
					
					//trace("PatternBuilder::build()", c, n );
					
					if( n is uint )
					{
						part = new MatchPattern( uint( n ) );
					}else if( qualifier.qualifies( c ) )
					{
						part = new QuantifierPattern( c )
					}
					
					/*
					trace("PatternBuilder::build()",
						part,
						parentTarget,
						getQualifiedClassName( part ),
						getQualifiedClassName( parentTarget ) );
					*/
					
					if( part != null )
					{
						parentTarget.add( part );
					}
					
					if( parentTarget is PatternGroup
						&& !(PatternGroup( parentTarget ).open ) )
					{
						trace("PatternBuilder::build()", "[CLOSING GROUP]", parentTarget, parentTarget.owner );	
						parentTarget = parentTarget.owner;
						current = parentTarget as Pattern;
					}
				}
				
				trace("[MATCHES] PatternBuilder::build()", matches.length, matches, output );
			}
			
			return output;
		}
	}
}