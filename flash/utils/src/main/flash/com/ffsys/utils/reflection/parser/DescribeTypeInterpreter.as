package com.ffsys.utils.reflection.parser {
	
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.io.xml.Deserializer;
	import com.ffsys.io.xml.DeserializeInterpreter;
	
	import com.ffsys.utils.reflection.Factory;
	
	/**
	*	Interpreter for the DescribeTypeParser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class DescribeTypeInterpreter extends DeserializeInterpreter {
		
		public function DescribeTypeInterpreter()
		{
			super();
		}
		
		override public function shouldProcessClass( node:XML, classReference:Class ):Boolean
		{
			if( classReference == Factory )
			{
				return true;
			}
			
			return false;
		}		
		
		override public function processClass( node:XML, parent:Object, classReference:Class ):Object
		{
			
			//trace( "DescribeTypeInterpreter processClass : " + classReference );
			
			if( classReference == Factory )
			{
				var path:String = node.@type;
				var factory:Class = getDefinitionByName( path ) as Class;
				var instance:Object;
				var reflection:Factory;
				
				/*
				var factoryReflection:Reflection = new Reflection( factory );
				
				if( factoryReflection.isStaticClass() )
				{
					throw new Error( "Cannot instantiate a static Object - possible interface." );
				}
				*/
				
				/*
				trace( "DescribeTypeInterpreter factory Class : " + factory );
				trace( "DescribeTypeInterpreter factory Class prototype : " + factory.prototype );
				trace( "DescribeTypeInterpreter factory Class constructor : " + factory.constructor );
				trace( "DescribeTypeInterpreter factory Class constructor prototype : " + factory.constructor.prototype );				
				*/
				
				try {
					instance = new factory() as factory;
					
					//trace( "DescribeTypeInterpreter factory instance : " + instance );
					
					if( instance )
					{
						//trace( "DescribeTypeInterpreter create Factory instance " );
						reflection = new Factory( instance );
					}
				}catch( e:Error )
				{
					throw new Error(
						"Could not create reflection factory instance, " +
						"possibly the constructor has required parameters." + e.toString() );
				}
				
				return reflection;
			}
			
			return new Object();
		}
		
	}
	
}
