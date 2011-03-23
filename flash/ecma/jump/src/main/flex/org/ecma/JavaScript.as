package org.ecma
{
	import flash.external.ExternalInterface;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	/**
	* 	Represents a bridge between Actionscript and
	* 	Javascript.
	*/
	dynamic public class JavaScript extends Proxy
	{
		private var _parent:JavaScript;
		private var _name:String;
		
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
		
		public function eval( js:String ):*
		{
			return invoke( "evaluate", [ js ] );
		}
		
		private function invoke( method:String, args:Array = null ):*
		{
			if( ExternalInterface.available )
			{
				if( args == null )
				{
					args = [];
				}
				args.unshift( method );
				
				trace("JavaScript::invoke()", args );
				
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
			//
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			trace("JavaScript::setProperty()", methodName, args );
			return invoke( methodName, args );
		}
	}
}