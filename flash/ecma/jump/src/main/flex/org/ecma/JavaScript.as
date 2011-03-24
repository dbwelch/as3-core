package org.ecma
{
	import flash.external.ExternalInterface;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	/**
	* 	Represents a bridge between Actionscript and
	* 	Javascript.
	*/
	dynamic internal class JavaScript extends Proxy
	{
		private var _parent:JavaScript = null;
		private var _name:String = null;
		
		private var _methodName:String;
		private var _methodArgs:Array;
		
		/**
		* 	Creates a <code>JavaScript</code> instance.
		*/
		public function JavaScript(
			parent:JavaScript = null, name:String = null )
		{
			super();
			_parent = parent;
			_name = name;
		}
		
		/**
		* 	The value of the javascript equivalent to this
		* 	action representation.
		* 
		* 	@return The value of the corresponding javascript object.
		*/
		public function valueOf():*
		{
			if( _methodName != null )
			{
				if( _parent == null )
				{
					return invoke( _methodName, _methodArgs );
				}else
				{				
					var path:String = toString();
					var js:String = path + "." + _methodName
						+ "("
						+ quoteArgs( _methodArgs )
						+ ");"
						
					trace("JavaScript::()call nested: ", js );
						
					return eval( js );
				}
			}else
			{
				return getVariable( this );
			}
		}
		
		/**
		* 	The name of this Javascript.
		*/
		public function get name():String
		{
			return _name;
		}
		
		/**
		* 	The parent of this Javascript.
		*/
		public function get parent():JavaScript
		{
			return _parent;
		}
		
		/**
		* 	Evaluates a Javascript string.
		* 
		* 	@param js The Javascript to evaluate.
		* 
		* 	@return The evaluated value.
		*/
		public function eval( js:String ):*
		{
			return invoke( "evaluate", [ js ] );
		}
		
		/**
		* 	Retrieves the value of a Javascript variable.
		* 
		* 	@param The Javascript representation of the variable name.
		* 
		* 	@return The value of the variable.
		*/
		public function getVariable( js:JavaScript ):*
		{
			if( js != null )
			{
				return eval( js.toString() );
			}
		}
		
		/**
		* 	Sets the value of a Javascript variable.
		* 
		* 	@param The Javascript representation of the variable name.
		* 	@param value The new value for the variable.
		*/
		public function setVariable( js:JavaScript, value:* ):void
		{
			if( js != null )
			{
				eval( js.toString() + "=" + quote( value ) );
			}
		}
		
		/**
		* 	@private
		*/
		internal function setMethodName( name:String ):void
		{
			_methodName = name;
		}
		
		/**
		* 	@private
		*/
		internal function setMethodArgs( args:Array ):void
		{
			_methodArgs = args;
		}
		
		/**
		* 	@private
		*/
		private function quote( value:* ):*
		{
			if( value is String )
			{
				return "\"" + value + "\"";
			}
			return value;
		}
		
		/**
		* 	@private
		*/
		private function quoteArgs( args:Array ):String
		{
			var output:String = "";
			for( var i:int = 0;i < args.length;i++ )
			{
				output += quote( args[ i ] );
				if( i < ( args.length - 1 ) )
				{
					output += ", ";
				}
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		private function invoke( method:String, args:Array = null ):*
		{
			if( ExternalInterface.available )
			{
				if( args == null )
				{
					args = [];
				}
				args.unshift( method );
				return ExternalInterface.call.apply( null, args );
			}
		}
		
		/*
		*	Proxy implementation.
		*/
		
		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			//TODO
			return false;
	    }
		
		/**
		*	@private	
		*/
	    override flash_proxy function getProperty( name:* ):*
		{
			return new JavaScript( this, name );
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			return 0;
		}
	
		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			return null;
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
		{
			return null;
		}
		
		/**
		*	@private	
		*/
	    override flash_proxy function setProperty( name:*, value:* ):void
		{
			setVariable( new JavaScript( _parent, name ), value );
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			var js:JavaScript = new JavaScript( _parent, _name );
			js.setMethodName( methodName );
			js.setMethodArgs( args );
			return js;
		}
		
		/**
		* 	A string representation of this Javascript
		* 	object.
		* 
		* 	@return A string representation of the object.
		*/
		public function toString():String
		{
			var names:Array = [];
			var p:JavaScript = _parent;
			if( _name != null )
			{
				names.push( _name );
			}			
			while( p != null )
			{
				if( p.name != null )
				{
					names.push( p.name );
				}
				p = p.parent;
			}
			names.reverse();
			var output:String = names.join( "." );
			return output;
		}
	}
}