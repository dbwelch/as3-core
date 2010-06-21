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
			
		private var _id:String;
		private var _locale:ILocale;
			
		//stores nested data collections
		private var _children:Array = new Array();
		
		//the parent collection
		private var _collection:IDataCollection = null;
		
		//non-child collections stored by identifier as the key
		private var _data:Dictionary = new Dictionary( true );
		
		//an array of the values
		private var _elements:Array = new Array();
		
		//an array of classes representing the valid data types
		protected var _types:Array = new Array();
		
		/**
		*	Creates an <code>AbstractDataCollection</code> instance.
		*/
		public function AbstractDataCollection()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get children():Array
		{
			return _children;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get data():Dictionary
		{
			return _data;
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
		
		/**
		*	@inheritDoc	
		*/
		public function get types():Array
		{
			return _types;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set collection( val:IDataCollection ):void
		{
			_collection = val;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get collection():IDataCollection
		{
			return _collection;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getCollectionById( id:String ):IDataCollection
		{
			if( id == this.id )
			{
				return this;
			}
			
			
			//look in our parent collection
			
			/*
			if( collection )
			{
				return collection.getCollectionById( id );
			}			
			*/
			
			//look in child collections
			var child:IDataCollection = null;
			var nested:IDataCollection = null;
			for each( child in _children )
			{
				nested = child.getCollectionById( id );
				if( nested )
				{
					return nested;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function removeCollectionById( id:String ):IDataCollection
		{
			var child:IDataCollection = null;
			for( var i:int = 0;i < _children.length;i++ )
			{
				child = IDataCollection( _children[ i ] );
				if( id == child.id )
				{
					_children.splice( i, 1 );
					return child;
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function addCollection( id:String, child:IDataCollection ):Boolean
		{
			if( id && child )
			{
				child.collection = this;
			
				if( !child.id )
				{
					child.id = id;
				}
				_children.push( child );
				return true;
			}
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get length():int
		{
			return _elements.length;
		}
		
		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			return ( _data[ name ] != null );
	    }
		
		/**
		*	@private	
		*/
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
		
		/**
		*	@private	
		*/
	    override flash_proxy function setProperty( name:*, value:* ):void
		{
			if( name == null )
			{
				return;
			}
			
			if( !ClassUtils.isType( types, value ) )
			{
				throw new TypeError(
					"IDataCollection: unacceptable data type '" +
					value + "' must be one of " + types );
			}
			
			if( value is IDataCollection )
			{
				addCollection( name, IDataCollection( value ) );
				return;
			}
			
			var hasProp:Boolean = ( _data[ name ] != null );
			_data[ name ] = value;
			
			//add all elements to the array of elements
			if( !hasProp )
			{
				_elements.push( value );
			}
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			//
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			if( index < length )
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
			var value:* = _elements[ index - 1 ];
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
			var value:* = _data[ name ];
			
			var collection:IDataCollection = getCollectionById( name );
			if( !value && collection )
			{
				return ( removeCollectionById( name ) != null );
			}
			
			var index:int = _elements.indexOf( value );
			if( index > -1 )
			{
				_elements.splice( index, 1 );
			}
			
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
			return _children;
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