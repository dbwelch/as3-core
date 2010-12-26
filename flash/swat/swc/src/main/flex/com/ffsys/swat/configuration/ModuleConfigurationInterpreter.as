package com.ffsys.swat.configuration {
	
	import com.ffsys.ioc.support.xml.BeanXmlInterpreter;
	
	/**
	*	Interpreter for a module configuration parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.12.2010
	*/
	public class ModuleConfigurationInterpreter extends BeanXmlInterpreter {
		
		/**
		*	Creates a <code>ModuleConfigurationInterpreter</code> instance.
		*	
		*	@param useStringReplacement Whether string replacement should be
		*	performed.
		*	@param strictStringReplacement Whether string replacement performs
		*	in a strict manner.
		*/
		public function ModuleConfigurationInterpreter(
			useStringReplacement:Boolean = true,
			strictStringReplacement:Boolean = true )
		{
			super();
			this.useStringReplacement = useStringReplacement;
			this.strictStringReplacement = strictStringReplacement;
		}
	}
}