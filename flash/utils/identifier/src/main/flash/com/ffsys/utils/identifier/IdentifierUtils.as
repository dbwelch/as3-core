package com.ffsys.utils.identifier {
	
	import com.ffsys.utils.string.AddressUtils;	
	import com.ffsys.utils.identifier.CamelCaseUtils;
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	Utility methods for working with
	*	<code>String</code> identifiers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class IdentifierUtils extends Object {
		
		/**
		*	Constant for an <code>id</code> property.	
		*/
		static public const ID_PROPERTY:String = "id";
		
		/**
		*	Constant for a <code>uid</code> property.	
		*/		
		static public const UID_PROPERTY:String = "uid";
		
		/**
		*	Constant for a <code>name</code> property.	
		*/		
		static public const NAME_PROPERTY:String = "name";	
		
		/**
		*	@private
		*/
		public function IdentifierUtils()
		{
			super();
		}
		
		/**
		*	Attempts to get an <code>id</code> for a
		*	<code>target</code> instance by trying to
		*	access the <code>ID_PROPERTY</code>, then the
		*	<code>UID_PROPERTY</code> and finally the
		*	<code>NAME_PROPERTY</code>.
		*	
		*	Returns <code>null</code> if an <code>id</code>
		*	could not be determined for the instance.
		*	
		*	@param target The <code>target</code> instance.
		*	
		*	@return An <code>id</code> if found.
		*/
		static public function getObjectId( target:Object ):String
		{	
			if(
				target.hasOwnProperty( ID_PROPERTY ) &&
				( target[ ID_PROPERTY ] is String ) )
			{
				return target[ ID_PROPERTY ];
			}else if(
				target.hasOwnProperty( UID_PROPERTY ) &&
				( target[ UID_PROPERTY ] is String ) )
			{
				return target[ UID_PROPERTY ];
			}else if(
				target.hasOwnProperty( NAME_PROPERTY ) &&
				( target[ NAME_PROPERTY ] is String ) )
			{
				return target[ NAME_PROPERTY ];
			}
			
			return null;			
		}		
		
		/**
		*	Given a file path this method gets a camel
		*	case <code>id</code> representation based
		*	on the file name.
		*
		*	@param path A file path.
		*
		*	@return The camel case <code>id</code> for the file.
		*/
		static public function getFileNameId( path:String ):String
		{
			var str:String = path;
			str = StringUtils.basename( str, true );
			str = StringUtils.removeExtension( str );
			
			str = CamelCaseUtils.toCamelCase( str, StringUtils.UNDERSCORE );
			str = CamelCaseUtils.toCamelCase( str, StringUtils.HYPHEN );
			
			return str;
		}
		
		/**
		*	Given a file path this method gets
		*	a camel case <code>id</code> representation
		*	of the parent directory.
		*	
		*	@param path A file path.
		*	
		*	@return The camel case <code>id</code>
		*	for the parent directory.
		*/
		static public function getParentId( path:String ):String
		{
			var str:String = null
			var values:Array = path.split( AddressUtils.DELIMITER );
			
			if( values && values.length > 1 )
			{
				//penultimate part
				str = values[ values.length - 2 ];
				
				str = CamelCaseUtils.toCamelCase(
					str, StringUtils.UNDERSCORE );
				
				str = CamelCaseUtils.toCamelCase(
					str, StringUtils.HYPHEN );
			}
			
			return str;
		}	
	}	
}