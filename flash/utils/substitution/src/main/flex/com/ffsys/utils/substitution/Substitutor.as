package com.ffsys.utils.substitution {
	
	import com.ffsys.utils.regex.RegexUtils;
	import com.ffsys.utils.string.PropertyNameConverter;
	
	/**
	*	Handles performing String substitution of the form:
	*
	*	<code>My string '{object.property}' value</code>
	*
	*	Whereby the code enclosed in the curly braces represents
	*	a public property lookup on the target instance passed to
	*	the Substitutor constructor. 
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.09.2007
	*/
	public class Substitutor extends Object
		implements ISubstitutor {
			
		static public var RELATIVE_PATH_DELIMITER:String = "./";
		static public var PATH_DELIMITER:String = ".";
		static public var START_DELIMITER:String = "{";
		static public var END_DELIMITER:String = "}";
		
		/**
		*	A collection of Binding instances to use when
		*	performing substitution.
		*/
		private var _namespaces:IBindingCollection;
		
		/**
		*	Determines whether String replacement is performed
		*	in a strict manner - throws runtime error.
		*/
		private var _strict:Boolean;
		
		/**
		*	The source String to perform substitution on.
		*/
		private var _source:String;
		
		/**
		*	The target Object to perform property lookup on.
		*/
		private var _target:Object;
		
		/**
		*	An optional parent instance that the String belongs to
		*	this allows the Substitutor to reassign the substituted
		*	String value after substitution.
		*/
		private var _parent:Object;
		
		/**
		*	The property name to set on the parent Object.
		*/
		private var _name:String;
		
		/**
		*	A formatter that can operate on the values that are
		*	retrieved during substitution lookup.
		*/
		private var _formatter:ISubstitutionFormatter;
		
		public function Substitutor(
			source:String = "",
			target:Object = null )
		{
			super();
			
			relativePathDelimiter = RELATIVE_PATH_DELIMITER;
			pathDelimiter = PATH_DELIMITER;
			startDelimiter = START_DELIMITER;
			endDelimiter = END_DELIMITER;
			namespaceDelimiter = Binding.DELIMITER;
			
			this.source = source;
			this.target = target;
			
			_namespaces = new BindingCollection();
			
			this.strict = true;
		}
		
		public function get regex():RegExp
		{
			var regex:RegExp = new RegExp(
				RegexUtils.escape( startDelimiter ) +
				"[^" +
				RegexUtils.escape( endDelimiter ) +
				"]+" +
				RegexUtils.escape( endDelimiter ),
				"g"
			);
			
			return regex;
		}
		
		public function set source( val:String ):void
		{
			_source = val;
		}
		
		public function get source():String
		{
			return _source;
		}
		
		public function set target( val:Object ):void
		{
			_target = val;
		}
		
		public function get target():Object
		{
			return _target;
		}
		
		public function set parent( val:Object ):void
		{
			_parent = val;
		}
		
		public function get parent():Object
		{
			return _parent;
		}
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set formatter( val:ISubstitutionFormatter ):void
		{
			_formatter = val;
		}
		
		public function get formatter():ISubstitutionFormatter
		{
			return _formatter;
		}		
		
		public function set namespaces( val:IBindingCollection ):void
		{
			_namespaces = val;
		}
		
		public function get namespaces():IBindingCollection
		{
			return _namespaces;
		}
		
		public function set strict( val:Boolean ):void
		{
			_strict = val;
		}
		
		public function get strict():Boolean
		{
			return _strict;
		}
		
		protected var _relativePathDelimiter:String;
		
		public function set relativePathDelimiter( val:String ):void
		{
			_relativePathDelimiter = val;
		}
		
		public function get relativePathDelimiter():String
		{
			return _relativePathDelimiter; 
		}
		
		protected var _pathDelimiter:String;
		
		public function set pathDelimiter( val:String ):void
		{
			_pathDelimiter = val;
		}
		
		public function get pathDelimiter():String
		{
			return _pathDelimiter; 
		}
		
		protected var _startDelimiter:String;
		
		public function set startDelimiter( val:String ):void
		{
			_startDelimiter = val;
		}
		
		public function get startDelimiter():String
		{
			return _startDelimiter; 
		}
		
		protected var _endDelimiter:String;
		
		public function set endDelimiter( val:String ):void
		{
			_endDelimiter = val;
		}
		
		public function get endDelimiter():String
		{
			return _endDelimiter;
		}
		
		protected var _namespaceDelimiter:String;
		
		public function set namespaceDelimiter( val:String ):void
		{
			_namespaceDelimiter = val;
		}
		
		public function get namespaceDelimiter():String
		{
			return _namespaceDelimiter; 
		}
		
		public function get matches():Array
		{
			return source.match( regex );
		}
		
		public function substitute():Object
		{
			
			//trace( "substitute : " + source );
			//trace( "substitute : " + isCandidate() );
			
			if( !isCandidate() )
			{
				return source;
			}
			
			if( !target )
			{
				throw new SubstitutionError(
					"Cannot perform String substitution on a null target Object." );
			}
			
			var replaced:Object = replacePropertyValues(
				target,
				matches,
				source ) as Object;
			
			//massage the name to deal with hyphenated values
			//quick fix for hyphenated property names
			if( name && name.indexOf( "-" ) > -1 )
			{
				var converter:PropertyNameConverter = new PropertyNameConverter();
				name = converter.convert( name );
			}
			
			//we always try to set the property silently
			if( parent
				&& name
				&& parent.hasOwnProperty( name ) )
			{
				parent[ name ] = replaced;
			}
			
			return replaced;	
		}		
		
		public function isCandidate():Boolean
		{
			return isSubstitutionCandidate( source, this );
		}
		
		/**
		*	Determines whether a given String has any String
		*	replacement candidates.
		*
		*	@param target the target String to inspect
		*
		*	@return a Boolean indicating if the target String contains any replacements
		*/
		static public function isSubstitutionCandidate(
			target:String = null,
			substitutor:Substitutor = null ):Boolean
		{	
			if( !substitutor )
			{
				substitutor = new Substitutor();
			}
			
			var re:RegExp = substitutor.regex;
			
			//trace( "isSubstitutionCandidate regexp : " + re );
			
			if( target )
			{
				var targetMatches:Array = target.match( re );
				return targetMatches && targetMatches.length;
			}
			
			return false;
		}
		
		/*
		*	Utility methods.
		*/
		
		private function replacePropertyValues(
			target:Object,
			values:Array,
			original:String ):Object
		{
			var i:int = 0;
			var l:int = values.length;
			
			var value:String = values[ i ];
			
			var replacement:Object;
			
			var candidate:SubstitutionCandidate;
			
			for( ;i < l;i++ )
			{
				value = values[ i ];
				
				//relative substitution, switch to the parent as the target
				if( value.indexOf( startDelimiter + relativePathDelimiter ) == 0 )
				{
					if( parent )
					{
						target = parent;
					}else{
						throw new SubstitutionError(
							"Relative substitution found " + value +
							" but no parent Object has been set." );
					}
				}
				
				candidate = new SubstitutionCandidate( this, target, value );
				
				candidate.strict = this.strict;
				candidate.namespaces = namespaces;
				candidate.parent = parent;
				
				replacement = candidate.lookup();
				
				//trace( "Substitutor replacement : " + replacement );
				
				if( replacement != null )
				{
					
 					if( formatter )
					{
						replacement = formatter.format( replacement );
					}
					
					//we're by reference to a non-String
					//type, we need to return the reference
					//if and only if the replacement candiate
					//matches the entire source. Ie the source
					//consists of one and only one replacement candidate
					//with no other characters, eg: "{object.property}"
					if( !( replacement is String )
						&& ( l == 1 )
						&& ( source == value )  )
					{
						return replacement;
					}
					
					original = original.replace( value, replacement );
					
				}
			}
		
			return original;
		}
		
	}
	
}
