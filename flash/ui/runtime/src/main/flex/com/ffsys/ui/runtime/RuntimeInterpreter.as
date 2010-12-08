package com.ffsys.ui.runtime {
	
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.css.IStyleAware;
	
	import com.ffsys.io.xml.*;
	
	import com.ffsys.utils.substitution.*;
	import com.ffsys.utils.xml.XmlUtils;
	
	/**
	*	Interpreter for the runtime view document parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeInterpreter extends DeserializeInterpreter {
		
		/**
		* 	Constant representing the id property field.
		*/
		public static const ID:String = "id";
	
		/**
		* 	Constant representing the filters property field.
		*/		
		public static const FILTERS:String = "filters";
		
		private var _document:IDocument;
		
		/**
		*	Creates a <code>RuntimeInterpreter</code> instance.
		*	
		*	@param useStringReplacement Whether string replacement should be
		*	performed.
		*	@param strictStringReplacement Whether string replacement performs
		*	in a strict manner.
		*/
		public function RuntimeInterpreter(
			useStringReplacement:Boolean = true,
			strictStringReplacement:Boolean = true )
		{
			super( useStringReplacement, strictStringReplacement );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function documentAvailable( instance:Object ):void
		{
			if( !( instance is IDocument ) )
			{
				throw new Error( "Invalid runtime document type for " + instance );
			}
			
			_document = IDocument( instance );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function complete( instance:Object ):void
		{
			super.complete( instance );
			
			//clean our reference
			_document = null;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function preProcess(
			node:XML, 
			instance:Object, 
			deserializer:Deserializer,
			contract:ISerializeContract ):Boolean
		{
			if( node.name().localName == RuntimeParser.EACH_NODE_NAME )
			{
				return true;
			}
			
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function process(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Object
		{
			
			if( node.name().localName == RuntimeParser.EACH_NODE_NAME )
			{
				var provider:String = null;
			
				var parent:DisplayObjectContainer = ( instance as DisplayObjectContainer );
			
				if( !parent )
				{
					throw new Error( "The parent for an each loop must be a display object container." );
				}
			
				//get a reference to the provider substitution string
				if( node.@provider != null && node.@provider.length > 0 )
				{
					provider = node.@provider;
				}else if( node.provider )
				{
					provider = node.provider.text()[0];
					delete node.provider;
				}
			
				//if the provider value is not a substitution candidate it is an error condition
				var isValid:Boolean = Substitutor.isSubstitutionCandidate( provider );
				if( !isValid )
				{
					throw new Error( "The each loop provider '" + provider + "' does not point to a complex object reference." );
				}
			
				//attempt to retrieve the value for the provider
				var substitutor:Substitutor =
					new Substitutor( provider, _document );
				substitutor.parent = instance;
				substitutor.namespaces = this.bindings;
				var value:Object = substitutor.substitute();

				//no provider found
				if( value == null )
				{
					throw new Error( "The each loop provider is null." );
				}
			
				//provider is not enumerable
				if( !( value is Array || value is Object ) )
				{
					throw new Error( "The each loop provider value '" + value + "' is not a valid type." );
				}
			
				//build up a temporary document to parse on each iteration
				var sample:XML = XmlUtils.getSimpleXmlNode(
					RuntimeParser.DOCUMENT_NAME );
			
				var i:int = 0;
				var l:int = node.children().length();
				var child:XML;
			
				for( ;i < l;i++ )
				{
					child = node.children()[ i ];
					sample.appendChild( child );
				}
			
				var bindings:IBindingCollection = this.bindings.clone();
				var binding:IBinding = null;
				var z:Object = null;
			
			
				var iteration:IDocument = null;
				var display:DisplayObject = null;
				var item:Object = null;
			
				for( z in value )
				{
					item = value[ z ];
					iteration = new Document();				
				
					binding = new Binding( Runtime.ITERATE_BINDING, { key: z, value: item } );
					bindings.addBinding( binding );

					var parser:RuntimeParser = new RuntimeParser();
					parser.interpreter.bindings = bindings;
					parser.deserialize( sample, iteration );
				
					for( i = 0;i < iteration.numChildren;i++ )
					{
						display = iteration.getChildAt( i );
						parent.addChild( display );
					}
				}
				return parent;
			}
			
			return instance;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			//handle storing identifier reference on the document
			if( value && value.hasOwnProperty( ID ) && ( value[ ID ] != null ) )
			{
				var id:String = value[ ID ];
				_document.identifiers[ id ] = value;
			}
			
			/*
			if( value is RuntimeEachLoop )
			{
				var eachLoop:RuntimeEachLoop = RuntimeEachLoop( value );
				var provider:String = eachLoop.provider;
				trace("RuntimeInterpreter::shouldSetProperty() EACH LOOP: ", eachLoop, provider, eachLoop.numChildren );
				
				return false;
			}
			*/
			
			if( name == FILTERS )
			{
				if( UIComponent.styleManager && parent is DisplayObject )
				{
					var display:DisplayObject = DisplayObject( parent );
					var filters:Array = display.filters ? display.filters : new Array();
					var ids:Array = String( value ).split( " " );
					var filter:BitmapFilter = null
					for( var i:int = 0;i < ids.length;i++ )
					{
						filter = UIComponent.styleManager.getFilter( ids[ i ] );
						filters.push( filter );
					}
					display.filters = filters;
				}
				
				return false;
			}
			
			if( value is DisplayObject )
			{
				return false;
			}
			
			//trace("RuntimeInterpreter::shouldSetProperty(), ", parent, name, value );
			
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function postProcessClass(
			instance:Object, parent:Object ):void
		{
			if( instance is DisplayObject )
			{
				var child:DisplayObject = DisplayObject( instance );
				
				if( child is IComponentGraphic )
				{
					var graphic:IComponentGraphic = IComponentGraphic( child );
					graphic.draw(
						graphic.preferredWidth, graphic.preferredHeight );
				}
				
				if( parent is DisplayObjectContainer )
				{
					
					/*
					//set the styles property after all other deserialization
					if( child is IStyleAware )
					{
						IStyleAware( child ).applyStyles();
					}
					*/
					
					DisplayObjectContainer( parent ).addChild( child );
				}
			}
		}
	}
}