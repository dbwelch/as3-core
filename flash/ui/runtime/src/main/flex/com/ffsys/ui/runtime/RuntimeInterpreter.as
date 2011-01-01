package com.ffsys.ui.runtime {
	
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.io.xml.*;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.common.ComponentIdentifiers;	
	import com.ffsys.ui.common.IStyleAware;
		
	import com.ffsys.ui.graphics.IComponentGraphic;

	import com.ffsys.ui.css.*;
	import com.ffsys.ui.graphics.*;	
	
	import com.ffsys.utils.substitution.*;
	import com.ffsys.utils.xml.XmlUtils;

	import com.ffsys.ioc.IBeanDocument;
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
		
		private var _runtime:IDocument;
		
		/**
		*	Creates a <code>RuntimeInterpreter</code> instance.
		*/
		public function RuntimeInterpreter( document:IBeanDocument = null )
		{
			super( document );
			this.useStringReplacement = true;
			this.strictStringReplacement = true;
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
			
			_runtime = IDocument( instance );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function complete( instance:Object ):void
		{
			super.complete( instance );
			
			//clean our reference
			_runtime = null;
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
			
			
				var iteration:IDocument = null;
				var display:DisplayObject = null;
				var item:Object = null;
			
				for( z in value )
				{
					item = value[ z ];
					iteration = new Document();				
					
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
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			
			var hasProp:Boolean = parent.hasOwnProperty( name );
			
			//trace("RuntimeInterpreter::shouldSetProperty(), ", parent, name, value, hasProp );	
			
			if( value is RuntimeBeanReference )
			{
				var beanName:String = RuntimeBeanReference( value ).ref;
				var bean:Object = this.document.getBean( beanName );
				
				if( bean == null )
				{
					throw new Error(
						"Could not locate bean reference with identifier '"
						 + beanName + "'." );
				}
				
				//replace the 
				//value = bean;
				
				if( hasProp )
				{
					//try to set the property to the bean value
					parent[ name ] = bean;
					return false;
				}
			}
			
			//handle storing identifier reference on the document
			if( value && value.hasOwnProperty( ID ) && ( value[ ID ] != null ) )
			{
				var id:String = value[ ID ];
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
				
				trace("RuntimeInterpreter::shouldSetProperty() FOUND FILTERS ELEMENT: ", parent, ( parent is IStyleManagerAware ) , styleManager  );
				
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
						trace("RuntimeInterpreter::shouldSetProperty() GOT FILTER: ", filter );
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
		
		/**
		*	@inheritDoc	
		*/
		override public function postProcessClass(
			instance:Object, parent:Object ):void
		{
			/*
			trace("RuntimeInterpreter::postProcessClass()", instance );
			
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
				
				if( parent is DisplayObjectContainer )
				{
					DisplayObjectContainer( parent ).addChild( child );
				}
			}
			
			super.postProcessClass( instance, parent );			
		}
	}
}