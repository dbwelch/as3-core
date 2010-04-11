package com.ffsys.utils.inspector {
	
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.identifier.IdentifierUtils;
	import com.ffsys.utils.string.StringUtils;
	
	//-->
	//import com.ffsys.utils.inspector.Inspector;
	
	/**
	*	Utility class for creating consistent
	*	<code>String</code> output for an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class ObjectInspector extends Object
		implements IObjectInspector {
		
		static public const START_DELIMITER:String = "[";
		static public const END_DELIMITER:String = "]";
		static public const ID_DELIMITER:String = "#";
		static public const PROPERTY_DELIMITER:String = ": ";
		
		static public const OBJECT_TITLE:String = "Object";
		static public const CLASS_TITLE:String = "Class";
		static public const PROPERTIES_TITLE:String = "Properties";
		static public const METHODS_TITLE:String = "Methods";
		static public const PARENT_TITLE:String = "Parent";
		
		static public const PARENT_PROPERTY:String = "parent";
		
		private var _instance:Object;
		private var _id:String;
		private var _title:String;
		private var _name:String;
		
		private var _detail:Object;
		private var _summary:Object
		
		private var _methods:Object;
		private var _properties:Object;
		private var _composites:Array;
		
		private var _options:ObjectInspectorOptions;
		
		public function ObjectInspector(
			instance:Object,
			options:ObjectInspectorOptions = null )
		{
			super();
			this.instance = instance;
			
			if( options )
			{
				this.options = options;
			}
			
			if( instance )
			{
				this.title = getClassObjectString( instance );
				this.name = getClassName( instance );
				this.id = IdentifierUtils.getObjectId( instance );
			}
		}
		
		public function getClassName( instance:Object ):String
		{
			
			if( instance is IObjectInspectorClassName )
			{
				return instance.getOutputClassName();
			}
			
			return ClassUtils.getClassName( instance );
		}
		
		protected function getClassObjectString( instance:Object ):String
		{
			return ( instance is Class ) ? CLASS_TITLE : OBJECT_TITLE;
		}
		
		public function set options( val:ObjectInspectorOptions ):void
		{
			_options = val;
		}
		
		public function get options():ObjectInspectorOptions
		{
			if( _options )
			{
				return _options;
			}
			
			return ObjectInspectorOptions.getGlobalOptions();
		}
		
		public function set instance( val:Object ):void
		{
			_instance = val;
		}
		
		public function get instance():Object
		{
			return _instance;
		}
		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}		
		
		public function set title( val:String ):void
		{
			_title = val;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set summary( val:Object ):void
		{
			_summary = val;
		}
		
		public function get summary():Object
		{
			return _summary;
		}		
		
		public function set detail( val:Object ):void
		{
			_detail = val;
		}
		
		public function get detail():Object
		{
			return _detail;
		}
		
		/**
		*	An Array of composite object instances that should be included
		*	in the String output. If this is set and is non-empty after the main
		*	String output a newline separated representation of each of the composite
		*	objects toString() output is added with an indent.
		*/
		public function set composites( val:Array ):void
		{
			_composites = val;
		}
		
		public function get composites():Array
		{
			return _composites;
		}
		
		public function set properties( val:Object ):void
		{
			_properties = val;
		}
		
		public function get properties():Object
		{
			return _properties;
		}
		
		public function set methods( val:Object ):void
		{
			_methods = val;
		}
		
		public function get methods():Object
		{
			return _methods;
		}		
		
		public function getSimpleObjectString( instance:Object ):String
		{
			var options:ObjectInspectorOptions = new ObjectInspectorOptions();
			options.simpleMode = true;
			var output:ObjectInspector = new ObjectInspector( instance, options );
			return output.getInstanceString();
		}
		
		protected function getInitialString(
			instance:Object,
			title:String = null,
			name:String = null,
			identifier:String = null ):String
		{
			var str:String = START_DELIMITER +
				( title ? title : getClassObjectString( instance ) ) +
				StringUtils.SPACE +
				( name ? name : getClassName( instance ) );
				
			var objectId:String =
				identifier ? identifier : IdentifierUtils.getObjectId( instance );
			
			if( options.includeId && objectId )
			{
				str += ID_DELIMITER + objectId;
			}
			
			str += END_DELIMITER;
			
			return str;
		}
		
		protected function getDetailString( instance:Object ):String
		{
			//return START_DELIMITER + instance.toString() + END_DELIMITER;
			
			var str:String = "";
			
			
			if( instance )
			{
			
				var detail:String = instance.toString();
			
				if( !detail.match( /^\[/ ) )
				{
					str += START_DELIMITER;
				}
			
				str += detail;
			
				if( !detail.match( /\]$/ ) )
				{
					str += END_DELIMITER;
				}
			
			}
			
			//str = StringUtils.rtrim( str ) + StringUtils.NEWLINE;
			
			return str;
		}
		
		protected function getParentString( instance:Object ):String
		{
			var str:String = StringUtils.INDENT +
				START_DELIMITER +
				PARENT_TITLE +
				END_DELIMITER;
			
			str += getSimpleObjectString( instance[ PARENT_PROPERTY ] );
			
			return str;			
		}
		
		protected function hasParentProperty( instance:Object ):Boolean
		{
			return options.includeParent &&
			instance.hasOwnProperty( PARENT_PROPERTY ) &&
			instance[ PARENT_PROPERTY ] &&
			instance[ PARENT_PROPERTY ] != instance;	
		}
		
		protected function getInstanceString():String
		{
			var str:String = getInitialString(
				this.instance, this.title, this.name, this.id );
			
			return str;
		}
		
		protected function getWrapperString( instance:Object ):String
		{
			var output:String = "";
			var instanceString:String;
			
			if( instance )
			{
				return instance.toString();
			}
			
			return output;
		}
		
		protected function getCompositesString():String
		{
			var str:String;
			
			if( composites && composites.length )
			{
				var indent:String = StringUtils.INDENT;
				
				if( hasParentProperty( this.instance ) )
				{
					indent = StringUtils.repeat( StringUtils.INDENT, 2 );
				}
				
				var i:int = 0;
				var l:int = composites.length;
				
				str = "";
				
				var instance:Object;
				var value:String;
				
				for( ;i < l;i++ )
				{
					instance = composites[ i ];
					
					if( ClassUtils.isNull( instance ) )
					{
						continue;
					}					
					
					value = getWrapperString( instance );
					
					if(
						instance is IObjectInspector &&
						!( value.match( new RegExp( "^" + indent + "[^\s].*" ) ) ) )
					{
						str += StringUtils.padLines( value, indent );
						
						if( !str.match( /\n$/ ) )
						{
							str += StringUtils.NEWLINE;
						}
						
					}else{
						str += indent + value + StringUtils.NEWLINE;
					}
				
					//trace( "ObjectInspector getCompositesString() : " + str );
				
				}
			}
			
			return str;
		}
		
		protected function getMethodPropertyString(
			target:Object,
			method:Boolean = false,
			title:String = null ):String
		{
			var str:String;
			
			if( !title )
			{
				title = PROPERTIES_TITLE;
			}
			
			if( target )
			{
				var z:String;
				var value:String;
				var instance:Object;
				
				for( z in target )
				{
					
					instance = target[ z ];
					value = "" + instance;
					
					if( !str )
					{
						str = StringUtils.INDENT +
						START_DELIMITER +
						name +
						StringUtils.SPACE +
						title +
						END_DELIMITER +
						StringUtils.NEWLINE;
					}
					
					if( method )
					{
						z += "()";
					}
					
					str += StringUtils.repeat( StringUtils.INDENT, 2 ) +
						START_DELIMITER +
						z +
						PROPERTY_DELIMITER +
						value +
						END_DELIMITER +
						StringUtils.NEWLINE;
											
				}
		
			}
			
			return StringUtils.rtrim( str );			
		}
		
		public function getPropertiesString():String
		{
			return getMethodPropertyString( properties );
		}
		
		public function getMethodsString():String
		{
			return getMethodPropertyString( methods, true, METHODS_TITLE );
		}
		
		public function getSimpleInspection():String
		{
			return getInstanceString();
		}		
		
		public function getComplexInspection():String
		{
			if( ClassUtils.isNull( this.instance ) )
			{
				return "" + this.instance;
			}
			
			if( options.inspect )
			{
				return Inspector.inspect( this.instance );
			}
			
			var str:String = getInstanceString();
			
			var methodsString:String = null;
			var propertiesString:String = null;
			var compositeString:String = null;
			
			if( options.includeDetail )
			{
				if( this.detail ||
					( this.detail is Number ) ||
					( this.detail is Boolean ) )
				{
					str += getDetailString( this.detail );
				}
			}			
			
			if( options.includeParent )
			{
				if( hasParentProperty( instance ) )
				{
					var parentString:String = getParentString( instance );
					str += StringUtils.NEWLINE + parentString;

				}
			}
					
			if( options.includeMethods )
			{
				methodsString = getMethodsString();
			
				if( methodsString )
				{
					str = StringUtils.rtrim( str );
					str += StringUtils.NEWLINE + methodsString;
				}
			}
			
			if( options.includeProperties )
			{
				propertiesString = getPropertiesString();
			
				if( propertiesString )
				{
					str = StringUtils.rtrim( str );
					str += StringUtils.NEWLINE + propertiesString;
				}
			}			
			
			if( options.includeComposites )
			{			
				compositeString = getCompositesString();
			
				if( compositeString )
				{
					str += StringUtils.NEWLINE + compositeString;
				}
			}
			
			if( options.includeSummary )
			{
				if( this.summary ||
					( this.summary is Number ) ||
					( this.summary is Boolean ) )
				{
					str += getDetailString( this.summary );
				}
			}			
			
			return str;
		}
		
		/*
		*	IObjectInspector implementation.
		*/
		
		/**
		*	@private	
		*/
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			
			output.name = this.name;
			output.title = this.title;
			output.id = this.id;
			output.detail = this.detail;			
			
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			return output;
		}

		/**
		*	@private	
		*/
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		/**
		*	@private	
		*/
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		/**
		*	@private	
		*/
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			//add a detail Object if necessary
			//output.detail = new Object();
			
			//pass in the default methods, properties and composites
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		/**
		*	@private	
		*/		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}
		
		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code>
		*	representation of this instance.
		*/		
		public function toString():String
		{
			return getObjectString( true );
		}
	}
}