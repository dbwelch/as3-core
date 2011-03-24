package org.flashx.utils.object {
	
	import org.flashx.utils.array.ArrayUtils;
	import org.flashx.utils.object.ClassUtils;
	import org.flashx.utils.string.StringUtils;
	
	/**
	*	Utility class for introspecting objects.
	*	
	*	Preference should be given to implementing
	*	<code>IObjectInspector</code> where possible.
	*	
	*	@see com.ffsys.utils.inspector
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.06.2007
	*/
	public class Inspector extends Object {
		
		public function Inspector()
		{
			super();
		}
		
		/**
		*	Trace the output of calling inspect() on an instance.
		*
		*	@param obj the instance to inspect
		*/
		static public function print( obj:* = null ):void
		{
			trace( inspect( obj ) );
		}
		
		/**
		*	Gets the String representation of an instance recursively,
		*	all public properties are exposed.
		*
		*	@param obj the instance to inspect
		*	@param indent the indent multiplier
		*	@param id a String (key) identifier for the instance
		*/		
		static public function inspect(
			obj:* = null,
			indent:int = 0,
			id:String = null,
			parents:Array = null ):String
		{
			//trace( "inspect : " + obj );
			//trace( "inspect : " + indent );
			
			if( !parents )
			{
				parents = new Array();
			}
			
			var l:int = 0;
			
			var prop:String = null;
			var str:String = "";
			var indentValue:String = "";
			
			var i:int = 0;
			for( ;i < indent;i++ )
			{
				indentValue += StringUtils.INDENT;
			}
			
			if( id )
			{
				str += indentValue + id + " : ";
				indentValue = "";
			}
			
			if( !obj && !( obj is Boolean ) )
			{
				str += indentValue + obj + StringUtils.NEWLINE;
				return str;
			}
			
			var strVal:String = obj.toString();
			
			//deal with circular references
			if( parents && ArrayUtils.contains( parents, obj ) )
			{
				str += strVal +
					" [CircularReference]" +
					StringUtils.NEWLINE;
				return str;
			}		 
			
			if( obj is Array )
			{
				strVal = "[object Array]";					
			}
			
			if( ( obj is XML ) || ( obj is XMLList ) )
			{
				str += indentValue +
					obj.toXMLString() +
					StringUtils.NEWLINE;
			}else if( obj is String || obj is Date )
			{
				str += indentValue +
					strVal +
					StringUtils.NEWLINE;
			}else if( obj is Number || obj is Boolean )
			{
				str +=
					indentValue +
					strVal +
					StringUtils.NEWLINE;
			}else if(
				ClassUtils.isPlainObject( obj ) ||
				ClassUtils.isPlainArray( obj ) )
			{
				str += indentValue +
					strVal +
					StringUtils.NEWLINE;
				
				parents.push( obj );
				
				if( obj is Array )
				{
					l = obj.length;
					for( i = 0;i < l;i++ )
					{
						str += indentValue +
							inspect( obj[ i ], indent + 1, i.toString(), parents );
					}					
				}else{
					for( prop in obj )
					{
						str += indentValue +
							inspect( obj[ prop ], indent + 1, prop, parents );
					}
				}
				
			}else if( ClassUtils.isCustomClass( obj ) )
			{
				str += indentValue +
					strVal +
					StringUtils.NEWLINE;
				
				parents.push( obj );
				
				if( obj is Array )
				{
					l = obj.length;
					for( i = 0;i < l;i++ )
					{
						str += indentValue +
							inspect( obj[ i ], indent + 1, i.toString(), parents );
					}					
				}else{
				
					var x:XML = ClassUtils.getPublicVariables( obj );
					var list:XMLList = x.children();
					var node:XML;

					for each( node in list )
					{
						prop = node.@name;
						str += indentValue +
							inspect( obj[ prop ], indent + 1, prop, parents );
					}
				
				}
				
			}
			
			return str;			
		}
	}
}