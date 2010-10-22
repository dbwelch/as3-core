package com.ffsys.io.xml {
	
	import com.ffsys.utils.substitution.ISubstitutionNamespace;
	import com.ffsys.utils.substitution.ISubstitutionNamespaceCollection;	
	import com.ffsys.utils.substitution.Substitutor;
	import com.ffsys.utils.substitution.SubstitutionNamespace;
	import com.ffsys.utils.substitution.SubstitutionNamespaceCollection;
	
	/**
	*	Represents a custom deserialization interpreter, this means
	*	a custom class can handle the deserialization process allowing
	*	for functionality such as extracting nodes and deleting them
	*	during the deserialization process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.07.2007
	*/
	public class DeserializeInterpreter extends Object
		implements IDeserializeInterpreter {
		
		private var _deserializer:Deserializer;
		
		/**
		*	A collection of SubstitutionNamespace instances to use when
		*	interpreting this deserialization pass.
		*/
		private var _stringSubstitutions:ISubstitutionNamespaceCollection;
		
		/**
		*	Determines whether this interpreter should perform
		*	automatic property lookup on the root instance
		*	when a String with a {instance.property} substring is encountered.
		*/
		private var _useStringReplacement:Boolean;
		
		/**
		*	Determines whether String replacement is performed
		*	in a strict manner - throws runtime error.
		*/
		private var _strictStringReplacement:Boolean;
		
		/**
		*	An array of the primitive String values that are
		*	candidates for replacement once deserialization is complete.
		*
		*	Each entry contains an Object with the following properties:
		*
		*	parent - the parent instance
		*	name - the String name of the property
		*	value - the String value for the property to perform replacement on
		*
		*/
		private var _stringSubstitutionCandidates:Array;
		
		public function DeserializeInterpreter(
			useStringReplacement:Boolean = false,
			strictStringReplacement:Boolean = false )
		{
			super();
			
			if( useStringReplacement )
			{
				_stringSubstitutionCandidates = [];
			}			
			
			this.useStringReplacement = useStringReplacement;
			this.strictStringReplacement = strictStringReplacement;
			
			_stringSubstitutions = new SubstitutionNamespaceCollection();
			
			//needs refactoring so it doesn't point to the same static
			//instance but uses a different instance that uses the
			//defaults as start values
			if( Deserializer.defaultStringSubstitutions )
			{
				
				//trace( "DEFAULTS : " + Deserializer.defaultStringSubstitutions );
				
				//--> cloning should work but fails on UriCollection
				//_stringSubstitutions = Deserializer.defaultStringSubstitutions.clone();
				
				_stringSubstitutions = Deserializer.defaultStringSubstitutions;
				
				/*
				var defaults:ISubstitutionNamespaceCollection = Deserializer.defaultStringSubstitutions;
				
				var i:int = 0;
				var l:int = defaults.getLength();
				
				var defaultSubstitution:ISubstitutionNamespace;
				
				for( ;i < l;i++ )
				{
					defaultSubstitution = defaults.getSubstitutionNamespaceAt( i );
					
					//trace( "Add default substitution : " + defaultSubstitution );
					
					_stringSubstitutions.addSubstitutionNamespace(
						defaultSubstitution.clone() );
				}
				
				trace( "OURS : " + _stringSubstitutions );
				*/
				
			}
		}
		
		public function set deserializer( val:Deserializer ):void
		{
			_deserializer = val;
		}
		
		public function get deserializer():Deserializer
		{
			return _deserializer;
		}
		
		public function get stringSubstitutions():ISubstitutionNamespaceCollection
		{
			return _stringSubstitutions;
		}
		
		public function set useStringReplacement( val:Boolean ):void
		{
			_useStringReplacement = val;
		}
		
		public function get useStringReplacement():Boolean
		{
			return _useStringReplacement;
		}
		
		public function set strictStringReplacement( val:Boolean ):void
		{
			_strictStringReplacement = val;
		}
		
		public function get strictStringReplacement():Boolean
		{
			return _strictStringReplacement;
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			return true;
		}
		
		public function shouldPostProcessPrimitive( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement && ( value is String ) )
			{
				return Substitutor.isSubstitutionCandidate( value as String );
			}
		
			return false;
		}
		
		public function postProcessPrimitive( parent:Object, name:String, value:Object ):void
		{
			if( useStringReplacement )
			{
				gatherSubstitutionCandidates( parent, name, value );
			}
		}
		
		private function gatherSubstitutionCandidates( parent:Object, name:String, value:Object ):void
		{
			var substitutor:Substitutor =
				new Substitutor( ( value as String ), null );
				
			substitutor.parent = parent;
			substitutor.name = name;
			
			_stringSubstitutionCandidates.push( substitutor );			
		}
		
		public function processClass( node:XML, parent:Object, classReference:Class ):Object
		{
			return new Object();
		}
		
		public function shouldProcessClass( node:XML, classReference:Class ):Boolean
		{
			return false;
		}
		
		public function shouldProcessNode( node:XML, instance:Object ):Boolean
		{
			return true;
		}
		
		public function preProcess(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Boolean
		{
			return false;
		}
		
		public function process(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Object
		{
			return new Object();
		}
		
		public function postProcessClass( instance:Object, parent:Object ):void
		{
			//
		}
		
		public function postProcess( node:XML, instance:Object, parent:Object ):void
		{
			//
		}
		
		public function shouldProcessAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement && ( value is String ) )
			{
				return Substitutor.isSubstitutionCandidate( value as String );
			}
			
			return false;
		}
			
		public function processAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement )
			{
				gatherSubstitutionCandidates( parent, name, value );
				return false;
			}
			
			return true;
		}
		
		public function complete( instance:Object ):void
		{

			if( useStringReplacement && _stringSubstitutionCandidates )
			{
			
				var i:int = 0;
				var l:int = _stringSubstitutionCandidates.length;
				
				var substitution:Substitutor;
				
				for( ;i < l;i++ )
				{
					substitution = _stringSubstitutionCandidates[ i ];
					
					substitution.namespaces = _stringSubstitutions;
					
					substitution.target = instance;
					substitution.substitute();
				}
				
				//clean up the candidates
				_stringSubstitutionCandidates = null;
			}
		}
		
	}
	
}
