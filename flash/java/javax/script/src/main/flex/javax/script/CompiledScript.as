package javax.script
{
	
	/**
	* 	Extended by classes that store results of compilations.
	* 
	* 	State might be stored in the form of Java classes, Java class files
	* 	or scripting language opcodes. The script may be executed repeatedly
	* 	without reparsing.
	* 
	* 	Each CompiledScript is associated with a ScriptEngine -- A call to an
	* 	eval method of the CompiledScript causes the execution of the script by
	* 	the ScriptEngine. Changes in the state of the ScriptEngine caused by
	* 	execution of tne CompiledScript may visible during subsequent executions
	* 	of scripts by the engine.
	*/
	public class CompiledScript extends Object
	{
		/**
		* 	Creates a <code>CompiledScript</code> instance.
		*/
		public function CompiledScript()
		{
			super();
		}
		
		/*
		
		 Object	eval() 
		          Executes the program stored in the CompiledScript object.
		 Object	eval(Bindings bindings) 
		          Executes the program stored in the CompiledScript object using the supplied Bindings of attributes as the ENGINE_SCOPE of the associated ScriptEngine during script execution.
		abstract  Object	eval(ScriptContext context) 
		          Executes the program stored in this CompiledScript object.
		abstract  ScriptEngine	getEngine() 
		          Returns the ScriptEngine wbose compile method created this CompiledScript.		
		
		*/
	
	}
}