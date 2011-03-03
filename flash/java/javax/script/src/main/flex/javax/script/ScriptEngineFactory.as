package javax.script
{
	
	/**
	* 	ScriptEngineFactory is used to describe and instantiate ScriptEngines.
	* 
	* 	Each class implementing ScriptEngine has a corresponding factory that
	* 	exposes metadata describing the engine class.
	* 
	* 	The ScriptEngineManager uses the service provider mechanism described
	* 	in the Jar File Specification to obtain instances of all ScriptEngineFactories
	* 	available in the current ClassLoader.
	*/
	public interface ScriptEngineFactory
	{
		
		/*
		
	 String	getEngineName() 
	          Returns the full name of the ScriptEngine.
	 String	getEngineVersion() 
	          Returns the version of the ScriptEngine.
	 List<String>	getExtensions() 
	          Returns an immutable list of filename extensions, which generally identify scripts written in the language supported by this ScriptEngine.
	 String	getLanguageName() 
	          Returns the name of the scripting langauge supported by this ScriptEngine.
	 String	getLanguageVersion() 
	          Returns the version of the scripting language supported by this ScriptEngine.
	 String	getMethodCallSyntax(String obj, String m, String... args) 
	          Returns a String which can be used to invoke a method of a Java object using the syntax of the supported scripting language.
	 List<String>	getMimeTypes() 
	          Returns an immutable list of mimetypes, associated with scripts that can be executed by the engine.
	 List<String>	getNames() 
	          Returns an immutable list of short names for the ScriptEngine, which may be used to identify the ScriptEngine by the ScriptEngineManager.
	 String	getOutputStatement(String toDisplay) 
	          Returns a String that can be used as a statement to display the specified String using the syntax of the supported scripting language.
	 Object	getParameter(String key) 
	          Returns the value of an attribute whose meaning may be implementation-specific.
	 String	getProgram(String... statements) 
	          Returns A valid scripting language executable progam with given statements.
	 ScriptEngine	getScriptEngine() 
	          Returns an instance of the ScriptEngine associated with this ScriptEngineFactory.		
		
		*/
	}
}