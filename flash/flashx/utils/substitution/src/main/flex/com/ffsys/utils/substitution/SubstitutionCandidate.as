package com.ffsys.utils.substitution {
	
	import com.ffsys.utils.regex.RegexUtils;
	
	/**
	*	Encapsulates a String substitution candidate in the
	*	form:
	*
	*	{object.property}
	*
	*	And the target Object that the public property lookup should
	*	be performed on. 
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.09.2007
	*/
	internal class SubstitutionCandidate extends Object
		implements ISubstitutor {
		
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
		
		private var _target:Object;
		private var _parent:Object;
		private var _source:String;
		
		private var _methodName:String;
		
		private var _methodParts:int;
		
		protected var _substitutor:Substitutor;
		
		public function SubstitutionCandidate(
			substitutor:Substitutor, 
			target:Object,
			source:String )
		{
			super();
			
			this.substitutor = substitutor;
			this.target = target;
			this.source = source;
			
			_namespaces = new BindingCollection();
			
			this.strict = true;
		}
		
		public function set substitutor( val:Substitutor ):void
		{ 
			_substitutor = val;
		}
		
		public function get substitutor():Substitutor
		{ 
			return _substitutor;
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
		
		public function set source( val:String ):void
		{
			_source = stripDelimiters( val );
			_source = _source.replace(
				new RegExp( RegexUtils.escape( substitutor.relativePathDelimiter ) ), "" );
		}
		
		public function get source():String
		{
			return _source;
		}
		
		public function set namespaces( val:IBindingCollection ):void
		{
			_namespaces = val;
			update();
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
		
		public function set methodName( val:String ):void
		{
			_methodName = val;
		}
		
		public function get methodName():String
		{
			return _methodName;
		}
		
		public function set methodParts( val:int ):void
		{
			_methodParts = val;
		}
		
		public function get methodParts():int
		{
			return _methodParts;
		}
		
		public function lookup():Object
		{
			return lookupTargetProperty( target, source );
		}
		
		public function hasNamespace():Boolean
		{
			var re:RegExp = new RegExp( "^[a-zA-Z0-9]*" + substitutor.namespaceDelimiter );
			var matches:Array = source.match( re );
			return matches && matches.length;
		}
		
		public function stripDelimiters( value:String ):String
		{
			//strip off the delimiters
			//return value.replace( /\{|\}/g, "" );
			
			var re:RegExp = new RegExp(
				RegexUtils.escape( substitutor.startDelimiter ) +
				"|" +
				RegexUtils.escape( substitutor.endDelimiter ),
				"g"
			);
			
			return value.replace( re, "" );
		}
		
		public function stripNamespace( value:String ):String
		{
			var index:int = value.indexOf( substitutor.namespaceDelimiter );
			if( index > -1 )
			{
				value = value.substr( index + 1 );
			}
			
			return value;
		}
		
		protected function updateFromNamespace( binding:IBinding ):void
		{
			
			if( binding )
			{
			
				//change the object pointer
				if( binding.target )
				{
					target = binding.target;
				
					//trace( "SET SUBSTIUTION TARGET : " + target );
				
				}
			
				if( binding.methodName )
				{
					methodName = binding.methodName;
				}
			
				if( binding.methodParts )
				{
					methodParts = binding.methodParts;
				}
			
			}
						
		}
		
		protected function update():void
		{
		
			if( namespaces )
			{
				var i:int = 0;
				var l:int = namespaces.getLength();	
				
				var binding:Binding;
				var prefix:String;
				
				for( ;i < l;i++ )
				{
					binding = Binding( namespaces.getBindingAt( i ) );
					
					if( binding.prefix && binding.prefix.length > 0 )
					{
						prefix = binding.prefix + substitutor.namespaceDelimiter;
					
						if( source.match( new RegExp( "^" + prefix ) ) )
						{
							updateFromNamespace( binding );
					
							//strip off the namespace
							source = stripNamespace( source );
						}
					
					}
				}
			}			
		}
		
		/**
		*	Accepts a target Object to perform the lookup on
		*	and substitution candidate in the String form:
		*
		*	{object.property}
		*
		*	And returns the resulting Object from the property
		*	lookup on the target Object.
		*
		*/
		private function lookupTargetProperty(
			instance:Object,
			value:String ):Object
		{
			var parts:Array = value.split( substitutor.pathDelimiter );
			
			var i:int = 0;
			var l:int = parts.length;
			
			var target:Object = instance;
			var nested:Object = null;
			
			var targets:Array = new Array();
			targets.push( target );
			
			var part:String;
			var parameter:String;
			
			for( ;i < l;i++ )
			{
				part = parts[ i ];
				
				/*
				trace( "SubstitutionCandidate lookup part : " + part );
				trace( "SubstitutionCandidate lookup methodName : " + methodName );
				trace( "SubstitutionCandidate lookup methodParts : " + methodParts );
				trace( "SubstitutionCandidate lookup instance : " + instance );
				*/
				
				try {	
					if( methodName && ( !methodParts || ( methodParts && ( i < methodParts ) ) ) )
					{
						
						parameter = part;
						
						/*
						if( l > 1 )
						{
							parameter = parts[ i + 1 ];
						}
						*/
						
						//trace( "SubstitutionCandidate call method : " + methodName );
						//trace( "SubstitutionCandidate call method parameter : " + parameter );
					
						//if( i == ( l - 2 ) || ( l == 1 ) )
						//{
						//if( !methodParts || ( methodParts && ( i < methodParts ) ) )
						//{
							
							try {
								
								target = target[ methodName ].apply( target, [ parameter ] );
							}catch( e:SubstitutionError )
							{
								throw new SubstitutionError(
									SubstitutionError.METHOD_INVOKE_FAILURE, methodName, target );
							}
						//}
						
						//}
					}else{
						
						/*
						if(
							!( target is ISubstitutionLookup ) &&
							!methodName &&
							!( target.hasOwnProperty( part ) ) )
						{
							throw new SubstitutionError(
								SubstitutionError.HAS_PROPERTY_FAILURE, part );
						}
						*/
						
						if( ( target is ISubstitutionLookup ) )
						{
							nested = ( target as ISubstitutionLookup ).getSubstitutionLookup( part );
						}else
						{
							nested = target[ part ];
						}
						
						//trace("SubstitutionCandidate::nested(), '" + nested + "'" );
						
						if( nested != null )
						{
							target = nested;
							targets.push( nested );
						//if we're not on the last part
						//throw an error
						}else if( i < ( l - 1 ) )
						{
							//thrown here so that the catch clause below is invoked
							throw new SubstitutionError(
								SubstitutionError.PROPERTY_LOOKUP_FAILURE, part );
						}
												
					}
				}catch( e:Error )
				{
					if( strict )
					{
						throw new SubstitutionError(
							SubstitutionError.LOOKUP_FAILURE,
							parts[ i ] + "\n\n" + e.toString() );			
					}
				}
				
				//dynamic classes won't fail
				//catch them here
				if( !methodName && ( target == null ) )
				{
					if( strict )
					{
						throw new SubstitutionError(
							SubstitutionError.LOOKUP_FAILURE,
							parts[ i ] );
					}
				}
				
				if( ( target != null ) && i == ( l - 1 ) )
				{
					//deal with property lookup target Objects that
					//resolve to String instances and contain Substitution
					//candidates that should be replaced
					if(
						( target is String ) &&
						Substitutor.isSubstitutionCandidate( target as String ) )
					{
						var lookupParent:Object;
					
						if( i > 0 )
						{
							lookupParent = targets[ i - 1 ];
						}else{
							lookupParent = targets[ 0 ];
						}
						
						var substitutor:Substitutor =
							new Substitutor( target as String, instance );
							
						substitutor.parent = this.parent ? this.parent : lookupParent;
						substitutor.name = part;
						substitutor.namespaces = namespaces;
						
						substitutor.strict = strict;
						
						return substitutor.substitute();
					}
					
					return target;
				}
				
			}
			
			return null;
		}
		
	}
	
}
