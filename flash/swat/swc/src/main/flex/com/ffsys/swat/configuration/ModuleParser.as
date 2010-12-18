package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;
	import com.ffsys.io.xml.ClassNodeNameMap;

	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.Locale;
	
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.swat.configuration.rsls.*;

	/**
	*	A parser implementation for the application configuration.
	*  
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ModuleParser extends Parser
		implements IModuleParser {		

		/**
		*	Creates a <code>ModuleParser</code> instance.
		*	
		*	@param root The class to instantiate for the root node.
		*	@param node The class to use when no mapping can be found.
		*/
		public function ModuleParser(
			root:Class = null, node:Class = null )
		{
			if( !root )
			{
				root = Configuration;
			}
			
			super( root, node );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			this.deserializer.parentField = PARENT_FIELD;
			
			var main:ConfigurationParser = new ConfigurationParser();
			main.addPathMappings( this.classNodeNameMap );
			main.addLocaleCollectionMappings( this.classNodeNameMap );			
			main.addResourceCollectionMappings( this.classNodeNameMap );
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:IModuleConfiguration = null ):IModuleConfiguration
		{
			return deserialize( x, target ) as IModuleConfiguration;
		}
	}
}