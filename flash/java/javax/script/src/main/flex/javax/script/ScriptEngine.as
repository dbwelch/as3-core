package javax.script
{
	
	/**
	* 	ScriptEngine is the fundamental interface whose methods
	* 	must be fully functional in every implementation of this specification. 
	*
	*	These methods provide basic scripting functionality. Applications
	* 	written to this simple interface are expected to work with minimal
	* 	modifications in every implementation. It includes methods that execute
	* 	scripts, and ones that set and get values.
	*
	*	The values are key/value pairs of two types. The first type of pairs consists
	* 	of those whose keys are reserved and defined in this specification or by
	* 	individual implementations. The values in the pairs with reserved keys have
	* 	specified meanings.
	*
	*	The other type of pairs consists of those that create Java language Bindings,
	* 	the values are usually represented in scripts by the corresponding keys or by
	* 	decorated forms of them.
	*/
	public interface ScriptEngine
	{
		
		/*
		
	 Bindings	createBindings() 
	          Returns an uninitialized Bindings.
	 Object	eval(Reader reader) 
	          Same as eval(String) except that the source of the script is provided as a Reader
	 Object	eval(Reader reader, Bindings n) 
	          Same as eval(String, Bindings) except that the source of the script is provided as a Reader.
	 Object	eval(Reader reader, ScriptContext context) 
	          Same as eval(String, ScriptContext) where the source of the script is read from a Reader.
	 Object	eval(String script) 
	          Executes the specified script.
	 Object	eval(String script, Bindings n) 
	          Executes the script using the Bindings argument as the ENGINE_SCOPE Bindings of the ScriptEngine during the script execution.
	 Object	eval(String script, ScriptContext context) 
	          Causes the immediate execution of the script whose source is the String passed as the first argument.
	 Object	get(String key) 
	          Retrieves a value set in the state of this engine.
	 Bindings	getBindings(int scope) 
	          Returns a scope of named values.
	 ScriptContext	getContext() 
	          Returns the default ScriptContext of the ScriptEngine whose Bindings, Reader and Writers are used for script executions when no ScriptContext is specified.
	 ScriptEngineFactory	getFactory() 
	          Returns a ScriptEngineFactory for the class to which this ScriptEngine belongs.
	 void	put(String key, Object value) 
	          Sets a key/value pair in the state of the ScriptEngine that may either create a Java Language Binding to be used in the execution of scripts or be used in some other way, depending on whether the key is reserved.
	 void	setBindings(Bindings bindings, int scope) 
	          Sets a scope of named values to be used by scripts.
	 void	setContext(ScriptContext context) 
	          Sets the default ScriptContext of the ScriptEngine whose Bindings, Reader and Writers are used for script executions when no ScriptContext is specified.		
		
		*/
	}
}