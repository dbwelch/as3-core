package com.ffsys.ui.runtime {
	
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	
	import com.ffsys.io.xml.*;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.common.ComponentIdentifiers;	
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.ui.dom.*;	
		
	import com.ffsys.ui.graphics.IComponentGraphic;

	import com.ffsys.ui.css.*;
	import com.ffsys.ui.graphics.*;	
	
	import com.ffsys.utils.substitution.*;
	import com.ffsys.utils.xml.XmlUtils;

	import com.ffsys.ioc.*;
	import com.ffsys.ioc.support.xml.BeanXmlInterpreter;
	
	/**
	*	Interpreter for the runtime view document parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeInterpreter extends BeanXmlInterpreter {
		
		/**
		* 	Constant representing the id property field.
		*/
		public static const ID:String = "id";
	
		/**
		* 	Constant representing the filters property field.
		*/
		public static const FILTERS:String = "filters";
		
		private var _runtime:IDomDocument;
		private var _references:Vector.<RuntimeDocumentReference> =
			new Vector.<RuntimeDocumentReference>();
		
		/**
		*	Creates a <code>RuntimeInterpreter</code> instance.
		*/
		public function RuntimeInterpreter( document:IBeanDocument = null )
		{
			super( document );
			this.useStringReplacement = false;
			this.strictStringReplacement = true;
		}
		
		public function set runtime( value:IDomDocument ):void
		{
			_runtime = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function primitive(
			node:XML = null,
			target:Object = null,
			name:String = null,
			attribute:Boolean = false,
			text:Boolean = false,
			value:* = null ):*
		{
			
			//getXmlBeanDescriptor
			
			trace("RuntimeInterpreter::primitive()", target, name, value);			
			var result:* = value;
			var descriptor:IBeanDescriptor = getXmlBeanDescriptor( node );
			if( descriptor != null )
			{
				trace("RuntimeInterpreter::primitive() INSTANTIATING PRIMITIVE FROM BEAN DOCUMENT!!!!!!!");
				result = getBeanFromDescriptor( node, descriptor );
			}
			
			if( text && value is String && result.hasOwnProperty( "text" ) )
			{
				result.text = ( value as String );
				

					trace(":::::::::::::::::::::::::::::::::::::::::::::::::: RuntimeInterpreter::primitive() SETTING TEXT VALUE ::::::::::::::::::::::::::::::::::::::::::::::::::", result.text );
				
			}
			trace("RuntimeInterpreter::primitive()", result );
			return result;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldProcessAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			if( name == ID )
			{
				return true;
			}
			return super.shouldProcessAttribute( parent, name, value );
		}	
		
		/**
		*	@inheritDoc
		*/	
		override public function processAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			trace("RuntimeInterpreter::processAttribute()", parent, name, value );
			if( name == ID )
			{
				return true;
			}			
			return super.processAttribute( parent, name, value );
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function documentAvailable( instance:Object, x:XML ):void
		{
			if( instance is IDomDocument )
			{
				_runtime = IDomDocument( instance );
				_runtime.xml = x;
			}
			
			//doWithComponent( _runtime, x );
			//addComponentDynamicMethods( x, _runtime );
			
			//parse inline css declarations
			//TODO: re-integrate with DOM style element
			/*
			var list:XMLList = x..css;
			if( list != null )
			{
				var node:XML = null;
				for each( node in list )
				{
					var css:String = node.text()[ 0 ];
			
					if( css != null
					 	&& css != "" )
					{
						if( _runtime.stylesheet == null )
						{
							throw new Error(
								"Cannot parse an inline css declaration for a view with"
								+ " no style sheet assigned to the document." );
						}

						_runtime.stylesheet.parse( css );
				
						//clean the inline css xml definition(s)
						delete x..css;
					}
				}
			}
			*/
		}
		
		/**
		* 	Resolves document level identifier references.
		* 
		* 	@param document The document containing the identifier references.
		*/
		protected function resolveReferences( document:IDomDocument ):void
		{
			var reference:RuntimeDocumentReference = null;
			var id:String = null;
			var parent:Object = null;
			var target:Object = null;			
			var name:String = null;
			for( var i:int = 0;i < _references.length;i++ )
			{
				reference = _references[ i ];
				id = reference.id;
				name = reference.name;
				parent = reference.parent;
				target = _runtime.identifiers[ id ] as Object;
				
				if( target == null )
				{
					throw new Error(
						"Could not locate a target for runtime document reference with identifier '"
						+ id + "'." );
				}
				
				//we have property lookup defined
				if( reference.property != null )
				{
					trace("RuntimeInterpreter::resolveReferences() RESOLVING PROPERTIES: ", reference.property );
				}
				
				try
				{
					if( parent.hasOwnProperty( name ) )
					{
						parent[ name ] = target;
					}
				}catch( e:Error )
				{
					//error setting the property - normally type coercion based
					//pass through the original error for easier debugging
					throw e;
				}
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override public function complete( instance:Object ):void
		{
			super.complete( instance );
			
			resolveReferences( _runtime );
			
			if( _runtime != null )
			{
				_runtime.prepared();
			}
			
			//clean our reference
			_runtime = null;
			_references = new Vector.<RuntimeDocumentReference>();
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
			if( node.name().localName == ComponentIdentifiers.ITERATOR )
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
			//TODO: re-implement with ERB style declarations
		
			/*
			if( node.name().localName == ComponentIdentifiers.ITERATOR )
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
					new Substitutor( provider, _runtime );
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
					ComponentIdentifiers.DOCUMENT );
			
				var i:int = 0;
				var l:int = node.children().length();
				var child:XML;
			
				for( ;i < l;i++ )
				{
					child = node.children()[ i ];
					sample.appendChild( child );
				}
			
				var bindings:IBindingCollection = null;
				var binding:IBinding = null;
				var z:Object = null;
			
				var iteration:IDomDocument = null;
				var display:DisplayObject = null;
				var item:Object = null;
			
				for( z in value )
				{
					item = value[ z ];
					
					//TODO: move to createDocument
					iteration = new DomDocument();
					
					bindings = this.bindings.clone();
					binding = new Binding( Runtime.ITERATE_BINDING, { key: z, value: item } );
					bindings.addBinding( binding );
					
					//trace("RuntimeInterpreter::complete()", this.document );

					var parser:RuntimeParser = new RuntimeParser( this.document );
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
			*/
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			
			var hasProp:Boolean = parent.hasOwnProperty( name );
			
			trace("RuntimeInterpreter::shouldSetProperty(), ", parent, name, value, hasProp );
			
			if( value is RuntimeDocumentReference )
			{
				var reference:RuntimeDocumentReference = RuntimeDocumentReference( value );
				reference.parent = parent;
				reference.name = name;
				_references.push( reference );
				return false;
			}
			
			if( value is RuntimeStyleReference )
			{
				var beanName:String = RuntimeStyleReference( value ).style;
				var bean:Object = this.document.getBean( beanName );
				
				if( bean == null )
				{
					throw new Error(
						"Could not locate bean reference with identifier '"
						 + beanName + "'." );
				}
				
				if( hasProp )
				{
					//try to set the property to the bean value
					parent[ name ] = bean;
					return false;
				}
			}
			
			//handle storing identifier reference on the document
			if( value
				&& value.hasOwnProperty( ID )
				&& ( value[ ID ] != null ) )
			{
				var id:String = value[ ID ];
				trace("RuntimeInterpreter::shouldSetProperty()", "ADDING DOCUMENT ID REFERENCE:", id, value );
				
				
				_runtime.identifiers[ id ] = value;
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
				var styleManager:IStyleManager = null;
				if( parent is IStyleManagerAware )
				{
					styleManager = IStyleManagerAware( parent ).styleManager;
				}
				
				//trace("RuntimeInterpreter::shouldSetProperty() FOUND FILTERS ELEMENT: ", parent, ( parent is IStyleManagerAware ) , styleManager  );
				
				if( styleManager != null
					&& parent is DisplayObject )
				{
					var display:DisplayObject = DisplayObject( parent );
					var filters:Array = display.filters ? display.filters : new Array();
					var ids:Array = String( value ).split( " " );
					var filter:BitmapFilter = null
					for( var i:int = 0;i < ids.length;i++ )
					{
						filter = styleManager.getFilter( ids[ i ] );
						//trace("RuntimeInterpreter::shouldSetProperty() GOT FILTER: ", filter );
						filters.push( filter );
					}
					display.filters = filters;
				}
				
				return false;
			}
			
			/*
			if( value is DisplayObject )
			{
				return false;
			}
			*/
			
			return hasProp;
		}
		
		protected function doWithComponent( component:IComponent, xml:XML ):void
		{
			//trace("RuntimeInterpreter::doWithComponent()", component, this.parser, ( this.parser is IParser ) );
			
			if( component is IDomXmlAware )
			{
				var target:IDomXmlAware = IDomXmlAware( component );
				target.xml = xml;
				target.parser = this.parser;
			}
		}
		
		override public function processClass(
			node:XML,
			parent:Object,
			classReference:Class ):Object
		{
			var target:Object = super.processClass(
				node, parent, classReference );

			doWithComponent( target as IComponent, node );
			if( target is IComponent )
			{
				addComponentDynamicMethods(
					node, IComponent( target ) );
			}
			
			return target;
		}
		
		protected function addComponentDynamicMethods( node:XML, component:IComponent ):void
		{
			//trace("RuntimeInterpreter::addComponentDynamicMethods()", node, component );
			
			//node.domComponent = component;
			
			/*
			node.debug = function():void
			{
				trace("Node::debug()", this.component );
			}
			
			
			XML.prototype.hello = function():void
			{
				trace("RuntimeInterpreter::addComponentDynamicMethods()", this );
			}
			
			var n:XML = new XML();			
			
			trace("RuntimeInterpreter::addComponentDynamicMethods()", node.debug is Function, n.hello is Function );
			*/
		}
		
		//TODO: return false when all child text nodes
		override public function shouldParseClassInstanceChildren(
			node:XML,
			parent:Object,
			classReference:Class,
			classInstance:Object ):Boolean
		{
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function postProcessClass(
			instance:Object, parent:Object ):void
		{
			//trace("RuntimeInterpreter::postProcessClass()", instance );
			
			/*
			
			if( instance is RectangleGraphic )
			{
				trace("RuntimeInterpreter::complete()", RectangleGraphic( instance ).pointer );
				
				if( RectangleGraphic( instance ).pointer )
				{
					trace("RuntimeInterpreter::complete()", RectangleGraphic( instance ).pointer.orientation );
				}
			}
			*/
			
			if( instance is IComponent )
			{
				IComponent( instance ).prefinalize();
			}
			
			if( instance is DisplayObject )
			{
				var child:DisplayObject = DisplayObject( instance );
				
				/*
				if( child is IComponentGraphic )
				{
					var graphic:IComponentGraphic = IComponentGraphic( child );
					graphic.draw(
						graphic.preferredWidth, graphic.preferredHeight );
				}
				*/
				
				if( parent is DisplayObjectContainer
				 	&& !parent.contains( child ) )
				{
					DisplayObjectContainer( parent ).addChild( child );
				}
			}
			
			super.postProcessClass( instance, parent );			
		}
	}
}