package javax.script
{
	
	/**
	* 	The optional interface implemented by ScriptEngines whose
	* 	methods allow the invocation of procedures in scripts that
	* 	have previously been executed.
	*/
	public interface Invocable
	{
		
		/*
		
		<T> T
		getInterface(Class<T> clasz) 
		          Returns an implementation of an interface using functions compiled in the interpreter.
		<T> T
		getInterface(Object thiz, Class<T> clasz) 
		          Returns an implementation of an interface using member functions of a scripting object compiled in the interpreter.
		 Object	invokeFunction(String name, Object... args) 
		          Used to call top-level procedures and functions defined in scripts.
		 Object	invokeMethod(Object thiz, String name, Object... args) 
		          Calls a method on a script object compiled during a previous script execution, which is retained in the state of the ScriptEngine.		
		
		*/
	}
}