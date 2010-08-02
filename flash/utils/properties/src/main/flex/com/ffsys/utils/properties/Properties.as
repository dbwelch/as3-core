package com.ffsys.utils.properties {
	
	import com.ffsys.core.address.AddressPath;
	import com.ffsys.core.address.IAddressPath;
	
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	import com.ffsys.utils.collections.strings.StringCollection;
	
	import com.ffsys.utils.substitution.Substitutor;
	
	/**
	*	Encapsulates the properties loaded from
	*	a properties file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	dynamic public class Properties extends StringCollection
		implements IProperties {
		
		/**
		*	The delimiter for path value pairs.	
		*/	
		public static const DELIMITER:String = "=";
			
		/**
		*	The delimiter used for path parts.
		*/
		public static const PATH_DELIMITER:String = ".";
		
		/**
		*	The delimiter used to determine comment lines.
		*/
		public static const COMMENT_DELIMITER:String = "#";
		
		/**
		*	Creates a <code>Properties</code> instance.
		*	
		*	@param locale A locale associated with these properties.
		*/
		public function Properties( locale:ILocale = null )
		{
			super();
			this.locale = locale;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getProperty(
			id:String, ... replacements ):String
		{
			var output:String = null;
			if( id )
			{
				var index:int = id.indexOf( PATH_DELIMITER );
				
				if( index == -1 )
				{
					//lookup the property on this instance
					
					if( replacements == null || replacements.length == 0 )
					{
						output = this[ id ];
					}else
					{
						output = substitute( id, replacements );
					}
				}else{
					//find the parent properties collection
					var enumerator:IAddressPath = new AddressPath(
						id, PATH_DELIMITER );
				
					//get the id of the target property
					var last:String =
						enumerator.removeLastPathElement();
	
					var target:IProperties = this;
					var element:String = null;
					var l:int = enumerator.getLength();
					for( var i:int = 0;i < l;i++ )
					{
						element = enumerator.getPathElementAt( i );
						target = target.getPropertiesById( element );
						
						if( !target )
						{
							break;
						}
					}

					if( target && ( i == l ) )
					{
						if( replacements == null || replacements.length == 0 )
						{
							output = target[ last ];
						}else
						{
							output = target.substitute( last, replacements );
						}
					}
				}
			}
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getPropertiesById( id:String ):IProperties
		{
			return getStringCollectionById( id ) as IProperties;
		}
		
		/**
		*	@inheritDoc
		*/
		public function substitute(
			id:String, replacements:Array ):String
		{
			var output:String = null;
			var source:String = this[ id ];
			
			if( !source )
			{
				throw new Error( "Could not locate property with identifier '"
				 	+ id + "'.");
			}
			
			var substitutor:Substitutor = new Substitutor(
				source, replacements );
				
			try
			{
				output = String( substitutor.substitute() );
			}catch( e:Error )
			{
				throw new Error(
					"Error encountered while performing property substitution with identifier '"
					+ id + "' and source '" + source + "'." );
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse( data:String ):void
		{
			//remove carriage returns
			data = data.replace( "\r", "" );
			
			var lines:Array = data.split( "\n" );
			var line:String = null;
			
			var index:int = -1;
			var path:String = null;
			var value:String = null;
			
			var comment:RegExp = 
				new RegExp( "\\s*" + COMMENT_DELIMITER + ".*" );
				
			var whitespace:RegExp = 
				new RegExp( "^\\s*$");				
			
			for( var i:int = 0;i < lines.length;i++ )
			{
				line = lines[ i ];
				
				if( comment.test( line ) || whitespace.test( line ) )
				{
					continue;
				}
				
				index = line.indexOf( DELIMITER );
				
				if( index == -1 )
				{
					throw new Error( "Cannot parse properties, no delimiter '"
					 	+ DELIMITER + "' found at line " + ( i + 1 ) + "." );
				}
				
				path = line.substr( 0, index );
				value = line.substr( index + 1 );
				
				//parse each line
				parsePropertyPath( path, value );
			}
		}
		
		/**
		*	@private	
		*/
		private function parsePropertyPath(
			path:String, value:String ):void
		{
			var enumerator:IAddressPath = new AddressPath(
				path, PATH_DELIMITER );
				
			//a collection to create for nested collections
			var nested:IStringCollection = null;
			
			if( enumerator.isRootPath() )
			{
				throw new Error( "Invalid property path encountered '"
				 	+ path + "'." );
			}
			
			//top level string
			if( enumerator.isTopLevelPath() )
			{
				//set the string on this collection
				this[ enumerator.getFirstPathElement() ] = value;
			}else
			{
				var target:IStringCollection = this;
				var existing:IStringCollection = null;
				var l:int = enumerator.getLength();
				var element:String = null;
				//complex path with nested collections
				for( var i:int = 0;i < l;i++ )
				{
					element = enumerator.getPathElementAt( i );

					if( i < ( l - 1 ) )
					{
						existing = target.getStringCollectionById( element );
						
						if( !existing )
						{
							existing = new Properties();
							
							//assign the collection
							target[ element ] = existing;
						}
						
						//update the current target collection
						target = existing;
						
					}else{
						//set the string property on the last path element
						target[ element ] = value;
					}
				}
			}
		}
	}
}