package javax.script
{
	import java.lang.ClassLoader;
	
	/**
	* 	The ScriptEngineManager implements a discovery and instantiation
	* 	mechanism for ScriptEngine classes and also maintains a collection
	* 	of key/value pairs storing state shared by all engines created by the Manager.
	* 
	* 	This class uses the service provider mechanism to enumerate
	* 	all the implementations of ScriptEngineFactory.
	* 
	* 	
	*/
	public class ScriptEngineManager extends Object
	{
		/**
		* 	Creates a <code>ScriptEngineManager</code> instance.
		* 
		* 	@param loader A class loader.
		*/
		public function ScriptEngineManager( loader:ClassLoader = null )
		{
			super();
		}
		
		/*
		
		 Object	get(String key) 
		          Gets the value for the specified key in the Global Scope
		 Bindings	getBindings() 
		          getBindings returns the value of the globalScope field.
		 ScriptEngine	getEngineByExtension(String extension) 
		          Look up and create a ScriptEngine for a given extension.
		 ScriptEngine	getEngineByMimeType(String mimeType) 
		          Look up and create a ScriptEngine for a given mime type.
		 ScriptEngine	getEngineByName(String shortName) 
		          Looks up and creates a ScriptEngine for a given name.
		 List<ScriptEngineFactory>	getEngineFactories() 
		          Returns an array whose elements are instances of all the ScriptEngineFactory classes found by the discovery mechanism.
		 void	put(String key, Object value) 
		          Sets the specified key/value pair in the Global Scope.
		 void	registerEngineExtension(String extension, ScriptEngineFactory factory) 
		          Registers a ScriptEngineFactory to handle an extension.
		 void	registerEngineMimeType(String type, ScriptEngineFactory factory) 
		          Registers a ScriptEngineFactory to handle a mime type.
		 void	registerEngineName(String name, ScriptEngineFactory factory) 
		          Registers a ScriptEngineFactory to handle a language name.
		 void	setBindings(Bindings bindings) 
		          setBindings stores the specified Bindings in the globalScope field.
		
		*/
	}
}