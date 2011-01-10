package com.ffsys.io.xml {
	
	import com.ffsys.utils.substitution.IBinding;
	import com.ffsys.utils.substitution.IBindingCollection;	
	import com.ffsys.utils.substitution.Substitutor;
	import com.ffsys.utils.substitution.Binding;
	import com.ffsys.utils.substitution.BindingCollection;
	
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
		*	A collection of Binding instances to use when
		*	interpreting this deserialization pass.
		*/
		private var _bindings:IBindingCollection;
		
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
		
		private var _parser:IParser;
		
		public function DeserializeInterpreter(
			useStringReplacement:Boolean = false,
			strictStringReplacement:Boolean = true )
		{
			super();		
			
			this.useStringReplacement = useStringReplacement;
			this.strictStringReplacement = strictStringReplacement;
			
			_bindings = new BindingCollection();
			
			if( Deserializer.defaultBindings )
			{
				//add default bindings to our bindings
				var binding:IBinding = null;
				for( var i:int = 0;i < Deserializer.defaultBindings.getLength();i++ )
				{
					binding = Deserializer.defaultBindings.getBindingAt( i );
					_bindings.addBinding( binding.clone() );
				}
			}
		}
		
		/**
		* 	A parser associated with this interpreter.
		*/
		public function get parser():IParser
		{
			return _parser;
		}
		
		public function set parser( value:IParser ):void
		{
			_parser = value;
		}
		
		public function set deserializer( val:Deserializer ):void
		{
			_deserializer = val;
		}
		
		public function get deserializer():Deserializer
		{
			return _deserializer;
		}
		
		public function get bindings():IBindingCollection
		{
			return _bindings;
		}
		
		public function set bindings( bindings:IBindingCollection ):void
		{
			_bindings = bindings;
		}
		
		public function set useStringReplacement( val:Boolean ):void
		{
			_useStringReplacement = val;
			
			if( val )
			{
				_stringSubstitutionCandidates = [];
			}else{
				_stringSubstitutionCandidates = null;
			}		
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
		* 	@inheritDoc
		*/
		public function documentAvailable( instance:Object, x:XML ):void
		{
			//do nothing by default
			//other implementations may want to to store a reference
			//to the document instance to perform operations
			//while the document is being deserialized
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function primitive(
			node:XML = null,
			target:Object = null,
			name:String = null,
			attribute:Boolean = false,
			text:Boolean = false,
			value:* = null ):*
		{
			return value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldPostProcessPrimitive( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement && ( value is String ) )
			{
				return Substitutor.isSubstitutionCandidate( value as String );
			}
		
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function postProcessPrimitive( parent:Object, name:String, value:Object ):void
		{
			if( useStringReplacement && _stringSubstitutionCandidates != null )
			{
				gatherSubstitutionCandidates( parent, name, value );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		private function gatherSubstitutionCandidates( parent:Object, name:String, value:Object ):void
		{
			var substitutor:Substitutor =
				new Substitutor( ( value as String ), null );
				
			substitutor.parent = parent;
			substitutor.name = name;
			
			_stringSubstitutionCandidates.push( substitutor );			
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldProcessClass( node:XML, parent:Object, classReference:Class ):Boolean
		{
			return false;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function processClass( node:XML, parent:Object, classReference:Class ):Object
		{
			return new Object();
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldParseClassInstanceChildren(
			node:XML, parent:Object, classReference:Class, classInstance:Object ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldProcessNode( node:XML, instance:Object ):Boolean
		{
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function preProcess(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function process(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Object
		{
			return new Object();
		}
		
		/**
		*	@inheritDoc
		*/
		public function postProcessClass( instance:Object, parent:Object ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function postProcess( node:XML, instance:Object, parent:Object ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function shouldProcessAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement && ( value is String ) )
			{
				return Substitutor.isSubstitutionCandidate( value as String );
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function processAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			if( useStringReplacement && _stringSubstitutionCandidates != null )
			{
				gatherSubstitutionCandidates( parent, name, value );
				return false;
			}
			
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
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
					
					substitution.namespaces = _bindings;
					
					substitution.target = instance;
					substitution.substitute();
				}
				
				//clean up the candidates
				_stringSubstitutionCandidates = null;
			}
		}
	}
}