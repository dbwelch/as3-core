package java.util.regex
{
	import javax.xml.namespace.QualifiedName;	
	
	/**
	* 	Represents a #ptnlib:term:rule;; a <em>rule</em>
	* 	is synonymous with the entire pattern of a regular expression.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.03.2011
	*/
	public class Rule extends Pattern
	{
		/**
		* 	The bean name for a rule.
		*/
		public static const NAME:String = "rule";
		
		/**
		* 	The attribute name for the rule flags.
		*/
		public static const FLAGS_ATTR_NAME:String = "flags";
		
		/**
		* 	Creates a <code>Rule</code> instance.
		* 
		* 	@param source The source for the rule.
		* 	@param flags The flags for the rule.
		*/
		public function Rule(
			source:* = null,
			flags:String = null )
		{
			super( source );
			if( flags != null )
			{
				this.flags = flags;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get patternType():uint
		{
			return Pattern.RULE_TYPE;
		}
		
		/**
		* 	@private
		*/
		override public function get nodeName():String
		{		
			return QualifiedName.toName(
				Pattern.NAMESPACE_PREFIX,
				NAME );
		}
		
		/**
		* 	The modifiers for this rule.
		* 
		* 	These can include the following:
		* 
		*	g - When using the replace() method of the String class, specify this
		* 	modifier to replace all matches, rather than only the first one.
		*	This modifier corresponds to the global property of the RegExp instance.
		* 
		*	i - The regular expression is evaluated without case sensitivity.
		* 	This modifier corresponds to the ignoreCase property of the RegExp instance.
		* 
		*	s - The dot (.) character matches new-line characters.
		* 	Note This modifier corresponds to the dotall property of the RegExp instance.
		* 
		*	m - The caret (^) character and dollar sign ($) match before and after new-line characters.
		* 	This modifier corresponds to the multiline property of the RegExp instance.
		* 
		*	x - White space characters in the re string are ignored, so that you can write more readable constructors.
		* 	This modifier corresponds to the extended property of the RegExp instance.
		* 
		*	All other characters in the flags string are ignored.
		*/
		public function get flags():String
		{
			var flags:String = "";
			if( global )
			{
				flags += GLOBAL_FLAG;
			}
			if( dotall )
			{
				flags += DOTALL_FLAG;
			}
			if( extended )
			{
				flags += EXTENDED_FLAG;
			}
			if( multiline )
			{
				flags += MULTILINE_FLAG;
			}
			if( ignoreCase )
			{
				flags += IGNORE_CASE_FLAG;
			}						
			return flags;
		}
		
		public function set flags( value:String ):void
		{
			if( value == null )
			{
				value = "";
			}
			value = value.replace( /[^xmigs]/g, "" );
			
			//regex is invalidated on flag change
			_regex = new RegExp( this.regex.source, value );
			
			setAttributeNS(
				Pattern.NAMESPACE_URI,
					QualifiedName.toName(
						Pattern.NAMESPACE_PREFIX,
						FLAGS_ATTR_NAME ),
				flags );
		}
		
		/**
		* 	Compiles a source string into this pattern.
		* 
		* 	@param source The source string to compile.
		*/
		public function compile( source:String ):void
		{
			__compile( source );
		}
		
		/**
		* 	@private
		* 	
		* 	Compiles a string to a pattern.
		* 
		* 	Any existing patterns belonging to this pattern
		* 	are removed before attempting to compile.
		* 
		* 	@param candidate The string candidate to compile.
		* 	@param list Whether this pattern should be treated
		* 	as a tree rather than a list structure.
		* 	@param target An optional target to compile into,
		* 	if not specified the pattern is compiled into this
		* 	pattern.
		* 
		* 	@return A compiled pattern.
		*/
		private function __compile(
			candidate:String,
			target:Rule = null ):Rule
		{
			if( target == null )
			{
				target = this;
			}
			
			if( candidate != null )
			{
				//clear();
				
				//TODO: remove all child elements but keep Comment
				
				//copy the candidate to our source
				_source = candidate.substr();
				_compiled = candidate.substr();
				
				if( isMetaSequence( _compiled ) )
				{
					//nothing to build for meta character sequences
					return target;
				}
				
				var parentTarget:Pattern = target;
				var opens:Boolean = false;
				var closes:Boolean = false;
				var meta:String = null;
				var ptn:Pattern = null;
				var data:String = null;
				var tmp:Pattern = null;

				var current:Pattern = null;				
						
				trace("[COMPILE] PatternBuilder::compile()", _compiled );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";
				
				//meta sequences '\b', '\n' etc, etc
				
				var expr:String = "(?:" + __sequence + "|\\?!|\\?:|\\?=|\\?P|\\[|\\]|[()|^\\$<>]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( _compiled );
				
				//no regex special character match
				if( results == null )
				{
					ptn = createPattern( _compiled );
					parentTarget.appendChild( ptn );
					parts.appendChild( ptn );
					return target;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					data = _compiled.substr( 0, results.index );
					ptn = getCompilationPattern( data );
					addCompilationPattern(
						parentTarget, ptn, true );
				}
				
				//grab the first pattern match
				if( results[ 1 ] is String )
				{
					ptn = getCompilationPattern( results[ 1 ] );
				}

				while( ptn != null )
				{
					opens = ptn.opens();
					closes = ptn.closes();
					
					if( opens
						&& parentTarget != null )
					{
						if( !( ptn.source == LESS_THAN ) )
						{
							addCompilationPart( ptn );
						}

						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = createPattern( ptn.source );
						current.appendChild( ptn );
						current.setOpen( true );
						ptn = current;
					}else
					{
						if( ptn.qualifier == null
							&& !( ptn.source == GREATER_THAN ) )
						{
							addCompilationPart( ptn );
						}
					}
					
					//
					addCompilationPattern( parentTarget, ptn );
					
					if( opens )
					{
						//opening a group update the parent target *after* adding the group
						parentTarget = current;
					}
					
					//close an open group
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						parentTarget = Pattern( current.owner );
						current = parentTarget;
					}

					//look for the next meta character sequence
					//to extract any intermediary chunk
					var next:int = _compiled.search( re );
					if( next > 0 )
					{
						//extract the non-meta character chunk
						data = _compiled.substr( 0, next );
					
						if( __quantity.test( data ) )
						{
							results = __quantity.exec( data );
							var c:String = results[ 1 ] as String;
							var just:Boolean = __justquantity.test( data );
							
							//trace("Pattern::compile()", "[FOUND QUANTITY CHUNK]", data, results, c, just, ptn );
							
							//quantifier with chunk data after
							//a group or character class so
							//split into quantifier and remaining
							//chunk
							if( c != null
								&& results.index == 0
								&& !just
								&& (
									closes
									&& ptn.source == RPAREN
									|| ptn.source == RBRACKET ) )
							{
								//trace("Pattern::compile()", "[FOUND MIXED QUANTITY CHUNK]" );
								
								//add the quantifier part
								addCompilationPattern(
									parentTarget,
									getCompilationPattern( data.substr( 0, c.length ) ),
									true );
								
								//re-assign the current chunk value
								data = data.substr( c.length );
							}else if( just && c != null )
							{
								data = c;
							}
						}

						ptn = createPattern( data );
						
						//trace("[COMPILE] Pattern::compile()", "[ADDING CHUNK]", data );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.grouping
							&& parentTarget.owner is Pattern
							&& parentTarget.firstPatternChild != null
							&& parentTarget.firstPatternChild.toString() == LESS_THAN )
						{	
							//assign the named property field to
							//the parent group
							Pattern( parentTarget.owner ).field = data;
						}else
						{
							addCompilationPart( ptn );
						}
						
						//add the chunk pattern
						addCompilationPattern( parentTarget, ptn );
					}
					
					//test for more meta sequences
					results = re.exec( _compiled );					
					ptn = null;
					if( results != null )
					{
						position = results.index;
						if( results[ 1 ] as String != null )
						{
							ptn = createPattern(
								results[ 1 ] as String );
						}
					}
				}
			}
			return target;
		}
		
		/*
		*	COMPILATION INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether the last attempt
		* 	to compile a pattern completed successfully.
		*/
		internal function get compiled():Boolean
		{
			return _compiled != null
				&& _source != null
				&& _compiled == "";
		}
		
		/**
		* 	@private
		*/
		internal function getCompilationPattern(
			data:String ):Pattern
		{
			return createPattern( data );
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPattern(
			parent:Pattern,
			ptn:Pattern,
			part:Boolean = false ):String
		{
			//chomp the matched string
			_compiled = _compiled.substr( ptn.source.length );
						
			//a cancelled meta character/sequence
			if( ptn.cancelled )
			{
				//fold into any previous character matching data
				//if we can
				if( ptn.previousPatternSibling.data )
				{
					ptn.previousPatternSibling.source += ptn.source;
					return _compiled;
				}else{
					//TODO?
					trace("Pattern::get compiled()", "[FOUND ESCAPED META SEQUENCE WITH NO PREVIOUS CHARACTER MATCH]", ptn );
				}
			}
			
			parent.appendChild( ptn );
			if( part )
			{
				addCompilationPart( ptn );
			}
			return _compiled;
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPart(
			ptn:Pattern ):Pattern
		{
			parts.appendChild( ptn );
			return parts;
		}		
	}
}