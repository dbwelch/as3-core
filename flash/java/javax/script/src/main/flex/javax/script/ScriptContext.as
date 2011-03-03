package javax.script
{
	
	/**
	* 	The interface whose implementing classes are used to connect
	* 	Script Engines with objects, such as scoped Bindings, in
	* 	hosting applications. Each scope is a set of named attributes
	* 	whose values can be set and retrieved using the ScriptContext methods.
	* 
	* 	ScriptContexts also expose Readers and Writers that can be used by
	* 	the ScriptEngines for input and output.
	*/
	public interface ScriptContext
	{
		/*	
		
	 Object	getAttribute(String name) 
	          Retrieves the value of the attribute with the given name in the scope occurring earliest in the search order.
	 Object	getAttribute(String name, int scope) 
	          Gets the value of an attribute in a given scope.
	 int	getAttributesScope(String name) 
	          Get the lowest scope in which an attribute is defined.
	 Bindings	getBindings(int scope) 
	          Gets the Bindings associated with the given scope in this ScriptContext.
	 Writer	getErrorWriter() 
	          Returns the Writer used to display error output.
	 Reader	getReader() 
	          Returns a Reader to be used by the script to read input.
	 List<Integer>	getScopes() 
	          Returns immutable List of all the valid values for scope in the ScriptContext.
	 Writer	getWriter() 
	          Returns the Writer for scripts to use when displaying output.
	 Object	removeAttribute(String name, int scope) 
	          Remove an attribute in a given scope.
	 void	setAttribute(String name, Object value, int scope) 
	          Sets the value of an attribute in a given scope.
	 void	setBindings(Bindings bindings, int scope) 
	          Associates a Bindings instance with a particular scope in this ScriptContext.
	 void	setErrorWriter(Writer writer) 
	          Sets the Writer used to display error output.
	 void	setReader(Reader reader) 
	          Sets the Reader for scripts to read input .
	 void	setWriter(Writer writer) 
	          Sets the Writer for scripts to use when displaying output.		
		
		*/
	}
}