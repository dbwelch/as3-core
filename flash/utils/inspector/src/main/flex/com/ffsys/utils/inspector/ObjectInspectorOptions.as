package com.ffsys.utils.inspector {
	
	/**
	*	Encapsulates the options available when using an
	*	<code>ObjectInspector</code> instance to generate
	*	the <code>String</code> representation of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class ObjectInspectorOptions extends Object
		implements IObjectInspector {
			
		static private var _globalOptions:ObjectInspectorOptions =
			new ObjectInspectorOptions();			
			
		private var _autoWrap:Boolean;
		private var _includeId:Boolean;
		private var _includeDetail:Boolean;
		private var _includeSummary:Boolean;
		private var _includeParent:Boolean;
		
		private var _includeMethods:Boolean;
		private var _includeProperties:Boolean;
		private var _includeComposites:Boolean;
		
		/**
		*	Replace the standard output with a call to
		*	Inspector.inspect() in the output.
		*/
		private var _inspect:Boolean;
		
		private var _simpleMode:Boolean;
		private var _verboseMode:Boolean;
		
		private var _valueStore:Array;
		
		public function ObjectInspectorOptions()
		{
			super();
			
			setVerboseMode();
			setValueStore();
			
			_inspect = false;
			
			_simpleMode = false;
			_verboseMode = true;
		}
		
		private function setVerboseMode():void
		{
			this.autoWrap = true;
			this.includeId = true;
			this.includeDetail = true;
			this.includeSummary = true;
			this.includeParent = false;
			this.includeMethods = true;
			this.includeProperties = true;
			this.includeComposites = true;			
		}
		
		private function setSimpleMode():void
		{
			this.autoWrap = true;
			this.includeId = true;
			this.includeDetail = false;
			this.includeSummary = false;
			this.includeParent = false;
			this.includeMethods = false;
			this.includeProperties = false;
			this.includeComposites = false;
		}
		
		private function setValueStore():void
		{
			_valueStore = new Array();
			_valueStore.push( autoWrap );
			_valueStore.push( includeId );	
			_valueStore.push( includeDetail );
			_valueStore.push( includeParent );
			_valueStore.push( includeComposites );
			_valueStore.push( includeProperties );
		}
		
		private function restoreFromValueStore():void
		{
			this.autoWrap = _valueStore[ 0 ];
			this.includeId = _valueStore[ 1 ];
			this.includeDetail = _valueStore[ 2 ];
			this.includeParent = _valueStore[ 3 ];
			this.includeComposites = _valueStore[ 4 ];
			this.includeProperties = _valueStore[ 5 ];
		}
		
		public function set inspect( val:Boolean ):void
		{
			_inspect = val;
		}
		
		public function get inspect():Boolean
		{
			return _inspect;
		}				
		
		public function set simpleMode( val:Boolean ):void
		{
			if( val )
			{
				setValueStore();
				setSimpleMode();
			}else{
				restoreFromValueStore();
			}
			
			_simpleMode = val;
			_verboseMode = !val;
		}
		
		public function get simpleMode():Boolean
		{
			return _simpleMode;
		}
		
		public function set verboseMode( val:Boolean ):void
		{
			if( val )
			{
				setValueStore();
				setVerboseMode();
			}else{
				restoreFromValueStore();
			}
			
			_verboseMode = val;
			_simpleMode = !val;
		}
		
		public function get verboseMode():Boolean
		{
			return _verboseMode;
		}		
		
		public function set autoWrap( val:Boolean ):void
		{
			_autoWrap = val;
		}
		
		public function get autoWrap():Boolean
		{
			return _autoWrap;
		}
		
		public function set includeId( val:Boolean ):void
		{
			_includeId = val;
		}
		
		public function get includeId():Boolean
		{
			return _includeId;
		}
		
		public function set includeDetail( val:Boolean ):void
		{
			_includeDetail = val;
		}
		
		public function get includeDetail():Boolean
		{
			return _includeDetail;
		}
		
		public function set includeSummary( val:Boolean ):void
		{
			_includeSummary = val;
		}
		
		public function get includeSummary():Boolean
		{
			return _includeSummary;
		}
		
		public function set includeParent( val:Boolean ):void
		{
			_includeParent = val;
		}
		
		public function get includeParent():Boolean
		{
			return _includeParent;
		}
		
		public function set includeMethods( val:Boolean ):void
		{
			_includeMethods = val;
		}
		
		public function get includeMethods():Boolean
		{
			return _includeMethods;
		}		
		
		public function set includeProperties( val:Boolean ):void
		{
			_includeProperties = val;
		}
		
		public function get includeProperties():Boolean
		{
			return _includeProperties;
		}		
		
		public function set includeComposites( val:Boolean ):void
		{
			_includeComposites = val;
		}
		
		public function get includeComposites():Boolean
		{
			return _includeComposites;
		}
		
		static public function setGlobalOptions( val:ObjectInspectorOptions ):void
		{
			
			//global options can never
			//have the inspect options as true
			val.inspect = false;
			
			_globalOptions = val;
		}
		
		static public function getGlobalOptions():ObjectInspectorOptions
		{
			return _globalOptions;
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
			
			output.autoWrap = this.autoWrap;
			output.includeId = this.includeId;
			output.includeDetail = this.includeDetail;
			output.includeParent = this.includeParent;
			output.includeComposites = this.includeComposites;
			output.includeProperties = this.includeProperties;			
			
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
			return getObjectString();
		}	
	}	
}