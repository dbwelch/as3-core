package com.ffsys.utils.collections.data {
	
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	import com.ffsys.utils.string.ClassUtils;
	
	import com.ffsys.utils.locale.ILocale;	
	
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	import com.ffsys.utils.inspector.IObjectInspectorClassName;
	
	/**
	*	Represents a collection of Strings that behave
	*	in a dynamic fashion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.07.2007
	*/
	dynamic public class AbstractDataCollection extends Proxy
		implements 	IDataCollection,
					IObjectInspector,
		 			IObjectInspectorClassName {
			
		//stores nested data collections
		protected var _collections:Array;
			
		protected var _collection:IDataCollection;
		
		protected var _data:Dictionary;
		
		protected var _elements:Array;
		
		protected var _id:String;
		
		protected var _dataTypes:Array;
		
		private var _locale:ILocale;
		
		public function AbstractDataCollection( dataTypes:Array = null )
		{
			super();
			_data = new Dictionary( true );
			_collections = new Array();
			_elements = new Array();
			
			if( !dataTypes )
			{
				dataTypes = new Array();
			}
			
			this.dataTypes = dataTypes;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get locale():ILocale
		{
			return _locale;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set locale( locale:ILocale ):void
		{
			_locale = locale;
		}
		
		public function set dataTypes( val:Array ):void
		{	
			_dataTypes = val;
		}
		
		public function get dataTypes():Array
		{
			return _dataTypes;
		}
		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		
		public function set collection( val:IDataCollection ):void
		{
			_collection = val;
		}
		
		public function get collection():IDataCollection
		{
			return _collection;
		}
		
		public function getCollectionById( id:String ):IDataCollection
		{
			var value:IDataCollection = null;
			
			for each( value in _collections )
			{
				if( value.id == id )
				{
					return value;
				}
			}
			
			//look in our parent collection
			if( collection )
			{
				return collection.getCollectionById( id );
			}
			
			return null;
		}
		
		public function getLength():int
		{
			return _elements.length;
		}
		
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			return ( _data[ name ] != null );
	    }
		
	    override flash_proxy function getProperty( name:* ):*
		{
			if( name == null )
			{
				return null;
			}
			
			if( _data[ name ] == null )
			{
				//we've got a collection with an id
				//that matches the property name
				//so we return that
				var collection:IDataCollection = getCollectionById( name );
				
				if( collection )
				{
					return collection;
				}
				
				throw new Error( "IDataCollection: could not locate property with id : " + name );
			}
			
			return _data[ name ];
	    }
		
	    override flash_proxy function setProperty( name:*, value:* ):void
		{
			if( name == null )
			{
				return;
			}
			
			if( !ClassUtils.isType( dataTypes, value ) )
			{
				throw new Error(
					"IDataCollection: unacceptable data type '" +
					value + "' must be one of " + dataTypes );
			}
			
			var hasProp:Boolean = ( _data[ name ] != null );
			
			if( value is IDataCollection )
			{
				( value as IDataCollection ).collection = this;
				
				_collections.push( value );
				
			}else
			{
				_data[ name ] = value;
			}
			
			//add all elements to the array of elements
			if( !hasProp )
			{
				_elements.push( value );
			}
	    }
		
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			//
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			trace("AbstractDataCollection::nextNameIndex()", index );
			
			if( index < getLength() )
			{
				return index + 1;
			}
		
			return 0;
		}
	
		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			//return _data[ name ];
			//return ( index - 1 ).toString();
			
			trace("AbstractDataCollection::nextName()", index, _elements.length, index - 1 );
			
			var value:* = _elements[ index - 1 ];
			
			trace("AbstractDataCollection::nextName() value", value );
			
			var z:String = null;
			for( z in _data )
			{
				if( _data[ z ] == value )
				{
					return z;
				}
			}
			
			return null;
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
		{
			return _elements[ index - 1 ];
		}
		
		/**
		* 	@private
		*/
		override flash_proxy function deleteProperty( name:* ):Boolean
		{
			return delete _data[ name ];
		}
		
		/*
		*	IObjectInspector implementation.	
		*/
		
		public function getOutputClassName():String
		{
			return "AbstractDataCollection";
		}
		
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			
			var key:String;
			var value:Object;
			
			for( key in _data )
			{
				value = _data[ key ];
				output[ key ] = value;
			}
			
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			return _collections;
		}

		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			//pass in the default methods, properties and composites
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		public function toString():String
		{
			return getObjectString( true );
		}
	}
}