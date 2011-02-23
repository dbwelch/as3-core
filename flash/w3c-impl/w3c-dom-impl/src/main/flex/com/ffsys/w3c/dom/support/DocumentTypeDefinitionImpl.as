package com.ffsys.w3c.dom.support
{	
	
	public class DocumentTypeDefinitionImpl extends Object {

		/**
		* 	A qualified name extracted from the document type definition.
		*/
		public var qualifiedName:String = null;

		/**
		* 	A public identifier declared in the document type definition.
		*/
		public var publicId:String = null;

		/**
		* 	A system identifier declared in the document type definition.
		*/
		public var systemId:String = null;

		/**
		* 	Creates an <code>DocumentTypeDefinitionImpl</code> instance.
		*/
		public function DocumentTypeDefinitionImpl( xml:XML )
		{
			super();
			extract( xml );
		}
		
		/**
		* 	@private
		*/
		private function extract( xml:XML ):void
		{
			var candidate:String = xml.toXMLString();

			candidate = candidate.replace( "<!-- <!DOCTYPE ", "" );
			candidate = candidate.replace( />\s*-->$/, "" );

			var tokens:Array = candidate.split( /\s+/ );
			var identifiers:Array = new Array();
			var identifier:String = null;

			//looking for identifiers
			if( tokens.length > 0 )
			{
				qualifiedName = tokens[ 0 ];
				var z:String = null;
				for each( z in tokens )
				{
					if( identifier != null )
					{
						identifier += " " + z;
					}				
					if( /^"/.test( z ) && identifier == null )
					{
						identifier = z;
					}
					if( /"$/.test( z ) )
					{
						identifier = identifier.replace( /^"/, "" );
						identifier = identifier.replace( /"$/, "" );
						identifiers.push( identifier );
						identifier = null;
					}
				}

				if( identifiers.length > 0 )
				{
					publicId = identifiers[ 0 ];
				}

				if( identifiers.length > 1 )
				{
					systemId = identifiers[ 1 ];
				}

				//trace("DocumentTypeDefinition::extract() IDENTIFIERS: ", qualifiedName, publicId, systemId );
			}
		}
	}
}