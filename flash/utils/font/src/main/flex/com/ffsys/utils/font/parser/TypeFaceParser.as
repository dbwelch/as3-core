package com.ffsys.utils.font.parser {
	
	import com.ffsys.io.xml.Parser;
	import com.ffsys.io.xml.DeserializeInterpreter;
	
	import com.ffsys.utils.font.ITypeFaceManager;
	import com.ffsys.utils.font.TypeFaceManager;
	
	import com.ffsys.utils.font.TypeFaceGroup;
	import com.ffsys.utils.font.TypeFace;
	import com.ffsys.utils.font.TypeFaceStyles;
	import com.ffsys.utils.font.TypeFaceStyle;
	
	/**
	*	Responsible for parsing the font definition
	*	document to an object structure.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2008
	*/
	public class TypeFaceParser extends Parser
		implements ITypeFaceParser {
		
		/**
		*	Creates a <code>TypeFaceParser</code> instance.
		*	
		*	@param root The Class to instantiate for the root node.
		*	@param node The default Class to use when no mapping
		*	can be found.
		*/
		public function TypeFaceParser(
			root:Class = null, node:Class = null )
		{
			
			if( !root )
			{
				root = TypeFaceManager;
			}
			
			super( root, node );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			//we don't do string replacement
			interpreter = new DeserializeInterpreter( false, false );
			
			classNodeNameMap.add(
				TypeFaceGroup,
				null,
				null,
				true );
				
			classNodeNameMap.add(
				TypeFace,
				null,
				null,
				true );
				
			classNodeNameMap.add(
				TypeFaceStyles,
				null,
				"styles" );
				
			classNodeNameMap.add(
				TypeFaceStyle,
				null,
				null,
				true );										
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:ITypeFaceManager = null ):ITypeFaceManager
		{
			return _deserializer.deserialize( x, target ) as ITypeFaceManager;
		}
	}	
}