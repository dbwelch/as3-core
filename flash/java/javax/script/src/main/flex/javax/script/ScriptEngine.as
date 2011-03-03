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
		
	}
}