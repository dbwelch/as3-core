package javax.script
{
	
	/**
	* 	Simple implementation of ScriptContext.
	*/
	public class SimpleScriptContext extends Object
		implements ScriptContext
	{
		
		/*
		
		
		Field Summary
		static int	ENGINE_SCOPE 
		          EngineScope attributes are visible during the lifetime of a single ScriptEngine and a set of attributes is maintained for each engine.
		static int	GLOBAL_SCOPE 
		          GlobalScope attributes are visible to all engines created by same ScriptEngineFactory.		
		
		*/	
		
		/*
		protected  Bindings	engineScope 
		          This is the engine scope bindings.
		protected  Writer	errorWriter 
		          This is the writer to be used to output errors from scripts.
		protected  Bindings	globalScope 
		          This is the global scope bindings.
		protected  Reader	reader 
		          This is the reader to be used for input from scripts.
		protected  Writer	writer 
		          This is the writer to be used to output from scripts.
		*/
			
		/**
		* 	Creates a <code>SimpleScriptContext</code> instance.
		*/
		public function SimpleScriptContext()
		{
			super();
		}
		
		
		/*
		
		Object	getAttribute(String name) 
		          Retrieves the value of the attribute with the given name in the scope occurring earliest in the search order.
		 Object	getAttribute(String name, int scope) 
		          Gets the value of an attribute in a given scope.
		 int	getAttributesScope(String name) 
		          Get the lowest scope in which an attribute is defined.
		 Bindings	getBindings(int scope) 
		          Returns the value of the engineScope field if specified scope is ENGINE_SCOPE.
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
		          Sets a Bindings of attributes for the given scope.
		 void	setErrorWriter(Writer writer) 
		          Sets the Writer used to display error output.
		 void	setReader(Reader reader) 
		          Sets the Reader for scripts to read input .
		 void	setWriter(Writer writer) 
		          Sets the Writer for scripts to use when displaying output.		
		
		*/
	}
}