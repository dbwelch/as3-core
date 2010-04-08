package com.ffsys.io.loaders.core {
	
	import com.ffsys.utils.array.ArrayUtils;
	
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Represents the data types that can be loaded using
	*	a remote address space.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.07.2007
	*/
	public class LoaderClassType extends Object {
		
		static public const REDIRECT_TYPE:String = "redirect";
		static public const XML_TYPE:String = "xml";
		static public const BINARY_TYPE:String = "binary";
		static public const TEXT_TYPE:String = "text";
		static public const CSS_TYPE:String = "css";
		static public const COMPILED_CSS_TYPE:String = "compiledCss";
		static public const VARIABLE_TYPE:String = "variable";
		static public const IMAGE_TYPE:String = "image";
		static public const MOVIE_TYPE:String = "movie";
		static public const SOUND_TYPE:String = "sound";
		static public const VIDEO_TYPE:String = "video";
		static public const SOCKET_TYPE:String = "socket";
		
		static public const VALID_TYPES:Array = [
			REDIRECT_TYPE,
			XML_TYPE,
			BINARY_TYPE,
			TEXT_TYPE,
			CSS_TYPE,
			COMPILED_CSS_TYPE,
			VARIABLE_TYPE,
			IMAGE_TYPE,
			MOVIE_TYPE,
			SOUND_TYPE,
			VIDEO_TYPE,
			SOCKET_TYPE
		];
		
		static private var _typeClassLookup:Object = {};
		
		/**
		*	@private
		*/
		public function LoaderClassType()
		{
			super();
		}
		
		static public function getLoaderClassByType( type:String ):Class
		{
			return _typeClassLookup[ type ];
		}
		
		/**
		*	Determines whether a remote address space type is valid.
		*
		*	@param type a String of the remote address space type
		*
		*	@return a Boolean indicating whether the remote address space type is valid
		*/
		static public function isValidType( type:String ):Boolean
		{
			return ArrayUtils.contains( VALID_TYPES, type );
		}
		
		static private function initialize():Boolean
		{
			if( _initialized )
			{
				return false;
			}
			
			_typeClassLookup[ XML_TYPE ] = XmlLoader;
			_typeClassLookup[ BINARY_TYPE ] = BinaryLoader;
			_typeClassLookup[ TEXT_TYPE ] = TextLoader;
			_typeClassLookup[ CSS_TYPE ] = StylesheetLoader;
			_typeClassLookup[ COMPILED_CSS_TYPE ] = CompiledStylesheetLoader;
			_typeClassLookup[ VARIABLE_TYPE ] = VariableLoader;
			_typeClassLookup[ IMAGE_TYPE ] = ImageLoader;
			_typeClassLookup[ MOVIE_TYPE ] = MovieLoader;
			_typeClassLookup[ SOUND_TYPE ] = SoundLoader;
			_typeClassLookup[ VIDEO_TYPE ] = VideoLoader;
			
			return true;
		}
		
		static private var _initialized:Boolean = initialize();				
		
	}
	
}
