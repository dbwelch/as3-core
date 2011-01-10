package com.ffsys.io.xml {
	
	import com.ffsys.utils.substitution.IBindingCollection;
	
	/**
	*	Describes the contract for instances
	*	that can handle the deserialization
	*	process itself, thereby allowing more
	*	complex deserialization control flow to occur.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.07.2007
	*/
	public interface IDeserializeInterpreter {
		
		function primitive(
			node:XML = null,
			target:Object = null,
			name:String = null,
			attribute:Boolean = false,
			text:Boolean = false,
			value:* = null ):*;
		
		function get parser():IParser;
		function set parser( value:IParser ):void;
	
		function set deserializer( val:Deserializer ):void;
		function get deserializer():Deserializer;
		
		function get bindings():IBindingCollection;
		function set bindings( bindings:IBindingCollection ):void;
		
		function set useStringReplacement( val:Boolean ):void;
		function get useStringReplacement():Boolean;
		
		function set strictStringReplacement( val:Boolean ):void;
		function get strictStringReplacement():Boolean;
		
		function shouldPostProcessPrimitive( parent:Object, name:String, value:Object ):Boolean;
		
		function postProcessPrimitive( parent:Object, name:String, value:Object ):void;
		
		/**
		* 	Determines whether an xml element should be processed.
		* 
		* 	When this method returns false the node will be not be
		* 	deserialized.
		* 
		* 	@param node The xml element being processed.
		* 	@param instance THe parent object the element belongs to.
		* 
		* 	@return Whether further deserialization should occur for the node.
		*/
		function shouldProcessNode( node:XML, instance:Object ):Boolean;
	
		
		function shouldProcessClass( node:XML, parent:Object, classReference:Class ):Boolean;
	
		function processClass( node:XML, parent:Object, classReference:Class ):Object;
		
		/**
		* 	Detrermines whether the parser should continue to parse child
		* 	elements when an interpreter is processing a class.
		*/
		function shouldParseClassInstanceChildren( node:XML, parent:Object, classReference:Class, classInstance:Object ):Boolean;
		
		
		/**
		* 	Invoked when the root object for the xml document is available.
		* 
		* 	@param instance The root object for the document.
		*/
		function documentAvailable( instance:Object, x:XML ):void;
		
		/**
		*	Should determine whether the interpreter handles the deserialization
		*	of this pass or whether the deserializer instance should continue
		*	parsing.
		*
		*	If this method returns true, the process() method is invoked, otherwise
		*	the Deserializer will continue with the default behaviour.
		*
		*	@return a Boolean indicating whether the process() method of the IDeserializeInterpreter should be invoked
		*/
		function preProcess(
			node:XML, 
			instance:Object, 
			deserializer:Deserializer,
			contract:ISerializeContract ):Boolean;
		
		/**
		*	Instructs the instance to deserialize from an XML serialized state
		*	into an Object structure.
		*
		*	@param x the source XML to deserialize from
		*	@param obj the current Object being deserialized into
		*	@param contract the ISerializeContract to deserialize against
		*
		*	@return the deserialized instance
		*/
		function process(
			node:XML,
			instance:Object,
			deserializer:Deserializer,
			contract:ISerializeContract ):Object;
		
		/**
		*	Allows post processing of the deserialized object.
		*
		*	@param obj the new deserialized instance
		*	@param parent the parent instance if available
		*/
		function postProcess( node:XML, instance:Object, parent:Object ):void;
		
		/**
		*	Allows post processing of the deserialized class instance.
		*
		*	@param instance the new deserialized instance
		*	@param parent the parent instance or null if there is no parent
		*/
		function postProcessClass( instance:Object, parent:Object ):void;
		
		/**
		*	Should determine whether a given attribute should be handled.
		*
		*	If this method returns true the processAttribute method will be invoked.
		*
		*	@param target the target Object the property should be set on
		*	@param name the String name of the attribute
		*	@param value the value for the attribute
		*
		*	@return a Boolean indicating whether this interpreter handles the attribute
		*/
		function shouldProcessAttribute( target:Object, name:String, value:Object ):Boolean;
		
		/**
		*	Processes an XML attribute.
		*
		*	@param target the target Object the property should be set on
		*	@param name the String name of the attribute
		*	@param value the value for the attribute
		*
		*	@return a Boolean indicating whether the deserializer should try to set
		*	the target property or not.
		*/		
		function processAttribute( target:Object, name:String, value:Object ):Boolean;
		
		/**
		*	Determines whether a property should be set on a parent instance.
		*	
		*	@param parent The parent object the property will be assigned to.
		*	@param name The name of the property being set.
		*	@param value The value the property will be set to.
		*	
		*	@return A boolean indicating whether the property should be
		*	set by the deserializer.
		*/
		function shouldSetProperty( parent:Object, name:String, value:* ):Boolean;
		
		/**
		* 	Invoked when parsing is complete.
		* 
		* 	@param instance The object the root element
		* 	was deserialized to.
		*/	
		function complete( instance:Object ):void;		
	}
	
}
