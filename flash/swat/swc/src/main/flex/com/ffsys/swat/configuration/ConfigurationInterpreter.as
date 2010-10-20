package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.Deserializer;
	
	import com.ffsys.io.xml.DeserializeInterpreter;
	
	import com.ffsys.utils.substitution.SubstitutionNamespace;
	import com.ffsys.swat.core.SwatFlashVariables;
	
	/**
	*	Interpreter for the configuration parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.10.2010
	*/
	public class ConfigurationInterpreter extends DeserializeInterpreter {
		
		public var flashvars:SwatFlashVariables;
		
		/**
		*	Creates a <code>ConfigurationInterpreter</code> instance.
		*	
		*	@param useStringReplacement Whether string replacement should be
		*	performed.
		*	@param strictStringReplacement Whether string replacement performs
		*	in a strict manner.
		*/
		public function ConfigurationInterpreter(
			useStringReplacement:Boolean = true,
			strictStringReplacement:Boolean = true )
		{
			super( useStringReplacement, strictStringReplacement );
		}
		
		/**
		*	Invoked when parsing is complete.
		*	
		*	Updates the bindings of the parser so that the
		*	configuration can use lookup in the <code>locale</code>
		*	binding namespace.
		*	
		*	@param instance The root instance of the object graph.
		*/
		override public function complete( instance:Object ):void
		{
			var configuration:IConfiguration = IConfiguration( instance );
			
			if( configuration.locales == null )
			{
				throw new Error( "The locales element was not specified." );
			}
			
			//update the selected locale
			configuration.locales.lang = flashvars.lang;
			
			//add the current locale as a default namespace
			Deserializer.defaultStringSubstitutions.addSubstitutionNamespace(
				new SubstitutionNamespace(
					"locale",
					configuration.locales.current )
			);
			
			//add the configuration as a default binding
			Deserializer.defaultStringSubstitutions.addSubstitutionNamespace(
				new SubstitutionNamespace(
					"configuration",
					configuration )
			);
			
			//ensure we always have some path information
			//even if none is declared in the config
			if( configuration.paths == null )
			{
				configuration.paths = new Paths();
			}
			
			super.complete( instance );
		}
	}
}