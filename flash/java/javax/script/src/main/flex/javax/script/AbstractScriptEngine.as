package javax.script
{
	/**
	* 	Provides a standard implementation for of the <code>eval</code> method.
	*/
	public class AbstractScriptEngine extends Object
		implements ScriptEngine
	{
		/**
		* 	Reserved key for a named value that passes an
		* 	array of positional arguments to a script.
		*/
		public static const ARGV:String = "javax.script.argv";
		
		/**
		* 	Reserved key for a named value that is the name
		* 	of the ScriptEngine implementation.
		*/
		public static const ENGINE:String = "javax.script.engine";
		
		/**
		* 	Reserved key for a named value that identifies the
		* 	version of the ScriptEngine implementation.
		*/
		public static const ENGINE_VERSION:String = "javax.script.engine_version";
		
		/**
		* 	Reserved key for a named value that is the name
		* 	of the file being executed.
		*/
		public static const FILENAME:String = "javax.script.filename";
		
		/**
		* 	Reserved key for a named value that is the full name of
		* 	Scripting Language supported by the implementation.
		*/
		public static const LANGUAGE:String = "javax.script.language";
		
		/**
		* 	Reserved key for the named value that identifies the version
		* 	of the scripting language supported by the implementation.
		*/
		public static const LANGUAGE_VERSION:String = "javax.script.language_version";
		
		/**
		* 	Reserved key for a named value that identifies the short
		* 	name of the scripting language.
		* 
		* 	The name is used by the ScriptEngineManager to locate a
		* 	ScriptEngine with a given name in the getEngineByName method.
		*/
		public static const NAME:String = "javax.script.name";
		
		/**
		* 	The default ScriptContext of this AbstractScriptEngine.
		* 
		* 	
		*/
		protected var context:ScriptContext;
		
		/**
		* 	Creates an <code>AbstractScriptEngine</code> instance.
		* 
		* 	Creates a new instance using the specified Bindings as
		* 	the ENGINE_SCOPE Bindings in the protected context field.
		* 
		* 	@param b The specified Bindings.
		*/
		public function AbstractScriptEngine( b:Bindings = null )
		{
			super();
		}
		
		/*
		
		Object	eval(Reader reader) 
		          eval(Reader) calls the abstract eval(Reader, ScriptContext) passing the value of the context field.
		 Object	eval(Reader reader, Bindings bindings) 
		          eval(Reader, Bindings) calls the abstract eval(Reader, ScriptContext) method, passing it a ScriptContext whose Reader, Writers and Bindings for scopes other that ENGINE_SCOPE are identical to those members of the protected context field.
		 Object	eval(String script) 
		          Same as eval(Reader) except that the abstract eval(String, ScriptContext) is used.
		 Object	eval(String script, Bindings bindings) 
		          Same as eval(Reader, Bindings) except that the abstract eval(String, ScriptContext) is used.
		 Object	get(String key) 
		          Gets the value for the specified key in the ENGINE_SCOPE of the protected context field.
		 Bindings	getBindings(int scope) 
		          Returns the Bindings with the specified scope value in the protected context field.
		 ScriptContext	getContext() 
		          Returns the value of the protected context field.
		protected  ScriptContext	getScriptContext(Bindings nn) 
		          Returns a SimpleScriptContext.
		 void	put(String key, Object value) 
		          Sets the specified value with the specified key in the ENGINE_SCOPE Bindings of the protected context field.
		 void	setBindings(Bindings bindings, int scope) 
		          Sets the Bindings with the corresponding scope value in the context field.
		 void	setContext(ScriptContext ctxt) 
		          Sets the value of the protected context field to the specified ScriptContext.		
		
		*/
		
		/**
		* 	Returns the value of the protected context field.
		*/
		public function getContext():ScriptContext
		{
			return context;
		}
		
		/**
		* 	Returns a SimpleScriptContext. The SimpleScriptContext:
		* 
		* 	<ul>
		* 		<li>Uses the specified Bindings for its ENGINE_SCOPE</li>
		* 		<li>Uses the Bindings returned by the abstract getGlobalScope
		* 		method as its GLOBAL_SCOPE</li>
		* 		<li>A SimpleScriptContext returned by this method is used to implement
		* 		eval methods using the abstract eval(Reader,Bindings) and
		* 		eval(String,Bindings) versions.</li>
		* 	</ul>
		* 
		* 	A SimpleScriptContext returned by this method is used to implement
		* 	eval methods using the abstract eval(Reader,Bindings) and eval(String,Bindings)
		* 	versions.
		*/
		protected function getScriptContext( nn:Bindings ):ScriptContext
		{
			//TODO
			return null;
		}
	}
}