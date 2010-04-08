package com.ffsys.utils.reflection {
	
	import com.ffsys.utils.string.ClassUtils;
	
	/**
	*	All static utility methods for working with the Reflection
	*	API.
	*
	*	We don't want this Class to compile the entire Reflection
	*	API and it's dependencies so we only try to output Reflection
	*	information if the the Reflection Class is available.
	*
	*	Optionally the methods of this Class can operate in a strict
	*	manner, meaning a runtime error is thrown if a Reflection instance
	*	could not be created.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.08.2007
	*/
	public class ReflectionUtils extends Object {
		
		/* force compilation of the Reflection API for testing purposes */
		//import com.ffsys.utils.reflection.Reflection;
		//private var importReflection:Reflection;
				
		static public const REFLECTION_CLASS:String =
			"com.ffsys.utils.reflection::Reflection";
		
		public function ReflectionUtils()
		{
			super();
		}
		
		static public function getReflection( target:Object, strict:Boolean = false ):Object
		{
			
			//declared as Object so we don't
			//compile the Reflection class			
			var reflection:Object = null;
			
			try {
				var classReference:Class =
					ClassUtils.getClassDefinition( REFLECTION_CLASS );
				reflection = new classReference( target );
			}catch( e:Error )
			{
				//throw an errror if we should be strict
				if( strict )
				{
					throw new Error(
						"ReflectionUtils.getReflection() : Could not create a Reflection " +
						"instance, ensure the Reflection API is compiled." );
				}
			}
			
			return reflection;
		}
		
		static public function getReflectionString(
			target:Object, strict:Boolean = false ):String
		{
			var reflection:Object = getReflection( target, strict );
			
			if( reflection )
			{
				return reflection.toString();
			}
			
			return null;
		}
	}
}