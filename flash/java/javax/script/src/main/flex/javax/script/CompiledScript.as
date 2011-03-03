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
	
		public function CompiledScript()
		{
			super();
		}
	
	}
}