package org.flashx.utils.properties {
	
	import org.flashx.core.address.AddressPath;
	import org.flashx.core.address.IAddressPath;
	
	import org.flashx.utils.locale.ILocale;
	
	import org.flashx.utils.collections.data.AbstractDataCollection;
	import org.flashx.utils.collections.data.IDataCollection;
	
	import org.flashx.utils.substitution.Substitutor;
	
	/**
	*	Represents a collection of string properties.
	* 
	* 	This implementation can parse property strings
	* 	declared in java-style properties notation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	dynamic public class Properties extends AbstractDataCollection
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
		*	The delimiter used to determine hard line breaks.
		*/
		public static const LINE_DELIMITER:String = "\\";
		
		/**
		*	The delimiter used to determine new lines.
		*/
		public static const NEWLINE:String = "\n";
		
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
		override public function get types():Array
		{
			return [ IProperties, String ];
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getProperty(
			id:String, ... replacements ):Object
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
			return getCollectionById( id ) as IProperties;
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
				
				/*
				throw new Error(
					"Error encountered while performing property substitution with identifier '"
					+ id + "' and source '" + source + "': " + e.message );
				*/
				
				throw e;
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
			
			var lines:Array = data.split( NEWLINE );
			var line:String = null;
			
			var index:int = -1;
			var path:String = null;
			var value:String = null;
			
			//expression for comment lines
			var comment:RegExp = 
				new RegExp( "\\s*" + COMMENT_DELIMITER + ".*" );	
				
			//expression for whitespace only lines
			var whitespace:RegExp = 
				new RegExp( "^\\s*$");
				
			//expression for hard line breaks
			var hardline:RegExp = 
				new RegExp( LINE_DELIMITER + LINE_DELIMITER + "+$");
				
			var multiline:Boolean = false;	
			var isMultiline:Boolean = false;
			var mpath:String = null;
			var mvalue:String = null;
			
			for( var i:int = 0;i < lines.length;i++ )
			{
				line = lines[ i ];
				
				if( comment.test( line ) || whitespace.test( line ) )
				{
					continue;
				}
				
				index = line.indexOf( DELIMITER );
				isMultiline = hardline.test( line );

				//got to the end of a multiline value
				if( multiline && !isMultiline )
				{
					mvalue += NEWLINE + line;	
					parsePropertyPath( mpath, mvalue );
					multiline = false;
					continue;
				}
				
				if( isMultiline )
				{
					//remove the hard line break escape character
					line = line.replace( hardline, "" );
					
					//first time around extract the property name and initial value
					if( !multiline )
					{
						verifyPropertyDelimiter( index, i );
						mpath = line.substr( 0, index );
						mvalue = line.substr( index + 1 );
					}else{
						mvalue += NEWLINE + line;
					}
					
					multiline = true;
				}else{
					verifyPropertyDelimiter( index, i );
					
					//normal name/value pair handling
					path = line.substr( 0, index );
					value = line.substr( index + 1 );	
					
					//parse each pair
					parsePropertyPath( path, value );									
				}
			}
		}
		
		/**
		* 	Performs parsing of the property value.
		* 
		* 	This allows implementations to perform type conversion
		* 	when a property document is parsed.
		* 
		* 	The default implementation passes the value through
		* 	untouched.
		* 
		* 	@param name The name of the property.
		* 	@param value The value of the property.
		* 
		* 	@return The parsed property value.
		*/
		protected function getPropertyValue( name:String, value:Object ):Object
		{
			return value;
		}
		
		/**
		* 	@private
		*/
		private function verifyPropertyDelimiter( index:int, i:int ):void
		{
			if( index == -1 )
			{
				throw new Error( "Cannot parse properties, no delimiter '"
				 	+ DELIMITER + "' found at line " + ( i + 1 ) + "." );
			}			
		}
		
		/**
		* 	Gets the implementation to use when creating child
		* 	property collections.
		* 
		* 	@return The properties implementation to use for
		* 	child collections.
		*/
		protected function getChildProperties():IProperties
		{
			return new Properties();
		}
		
		/**
		*	@private	
		*/
		private function parsePropertyPath(
			path:String, value:Object ):void
		{
			var enumerator:IAddressPath = new AddressPath(
				path, PATH_DELIMITER );
				
			//a collection to create for nested collections
			var nested:IDataCollection = null;
			
			if( enumerator.isRootPath() )
			{
				throw new Error( "Invalid property path encountered '"
				 	+ path + "'." );
			}
			
			value = getPropertyValue( path, value );
			
			//top level string
			if( enumerator.isTopLevelPath() )
			{
				//set the string on this collection
				this[ enumerator.getFirstPathElement() ] = value;
			}else
			{
				var target:IDataCollection = this;
				var existing:IDataCollection = null;
				var l:int = enumerator.getLength();
				var element:String = null;
				//complex path with nested collections
				for( var i:int = 0;i < l;i++ )
				{
					element = enumerator.getPathElementAt( i );
					
					//not on the last path part so find the target
					if( i < ( l - 1 ) )
					{
						existing = target.getCollectionById( element );
						
						//create the target collection if it doesn't exist
						if( !existing )
						{
							existing = getChildProperties();
							//assign the collection
							target[ element ] = existing;
						}
						//update the current target collection
						target = existing;
					//got to the end so set the property on the target
					}else{
						//set the string property on the last path element
						target[ element ] = value;
					}
				}
			}
		}
	}
}