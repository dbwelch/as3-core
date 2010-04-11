package com.ffsys.io.loaders.core {
	
	import flash.net.URLRequest;
	
	import com.ffsys.utils.address.AddressUtils;
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.FileTypeRegistry;
	import com.ffsys.io.loaders.types.TextLoader;
	
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	Given a value this factory will attempt to create the correct ILoader
	*	Class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public class LoaderFactory extends Object {
		
		public function LoaderFactory()
		{
			super();
		}
		
		static public function create(
			value:Object,
			type:String = null,
			baseUri:String = "" ):ILoader
		{
			var loader:ILoader;
			var loaderClass:Class;
			
			var absolute:String = null;

			if( value is String )
			{
				absolute = AddressUtils.concatenate( baseUri, value as String, true );
			}else if( value is URLRequest )
			{
				absolute = URLRequest( value ).url;
			}

			loaderClass = LoaderClassType.getLoaderClassByType( type );

			if( !loaderClass || !( loaderClass is Class ) )
			{
				
				var registry:FileTypeRegistry = FileTypeRegistry.getInstance();
				
				var extension:String = StringUtils.getExtension( absolute );
				
				loaderClass = registry.get( extension );
				
				if( !loaderClass )
				{
					//default type used for loading data
					loaderClass = TextLoader;
				}
				
			}
			
			try {
				loader = new loaderClass() as ILoader;
			}catch( e:Error )
			{
				throw new Error(
					"LoaderFactory: Unable to instantiate ILoader class: " + loaderClass );
			}			
			
			loader.uri = absolute;
			
			return loader;		
		}
		
	}
	
}
