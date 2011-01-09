package com.ffsys.swat.configuration {

	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.BeanXmlInterpreter;
	
	import com.ffsys.io.xml.Deserializer;
	
	import com.ffsys.utils.substitution.Binding;
	import com.ffsys.swat.core.Bindings;
	import com.ffsys.swat.core.DefaultFlashVariables;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	*	Interpreter for the configuration parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.10.2010
	*/
	public class ConfigurationInterpreter extends BeanXmlInterpreter {
		
		/**
		* 	The application flash variables.
		*/
		public var flashvars:DefaultFlashVariables;
		
		/**
		*	Creates a <code>ConfigurationInterpreter</code> instance.
		*	
		*	@param document The bean document.
		*/
		public function ConfigurationInterpreter(
			document:IBeanDocument = null )
		{
			super( document );
			this.useStringReplacement = false;
			this.strictStringReplacement = true;
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
			//handle the main configuration
			if( instance is IConfiguration )
			{
				var configuration:IConfiguration = IConfiguration( instance );
			
				if( configuration.locales == null )
				{
					throw new Error( "The locales element was not specified." );
				}
			
				//update the selected locale
				configuration.locales.lang = flashvars.lang;
			
				//trace("ConfigurationInterpreter::complete()", "SET CURRENT LOCALE: ", flashvars.lang, configuration.locales.lang, configuration.locales.current );
			
				//add the current locale as a default namespace
				Deserializer.defaultBindings.addBinding(
					new Binding(
						Bindings.LOCALE,
						configuration.locales.current )
				);
			
				//add the configuration as a default binding
				Deserializer.defaultBindings.addBinding(
					new Binding(
						Bindings.CONFIGURATION,
						configuration )
				);
			
				//add the locales as a default binding
				Deserializer.defaultBindings.addBinding(
					new Binding(
						Bindings.LOCALES,
						configuration.locales )
				);
			
				//ensure we always have some path information
				//even if none is declared in the config
				if( configuration.paths == null )
				{
					configuration.paths = new Paths();
				}
			
				//assign the path to the current locale
				configuration.paths.locale = configuration.paths.getLocalePath(
					IConfigurationLocale( configuration.locales.current ) );
			
				//add the paths as a default binding
				Deserializer.defaultBindings.addBinding(
					new Binding(
						Bindings.PATHS,
						configuration.paths )
				);
			}
			
			super.complete( instance );
		}
	}
}