package com.ffsys.io.loaders.core {

	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Creates a mapping between file extensions and the correct loader to use
	*	for loading that type of file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class FileTypeRegistry extends Object {
		
		static private var _instance:FileTypeRegistry;
		
		private var _dict:Dictionary;
		
		public function FileTypeRegistry()
		{
			super();
			_dict = new Dictionary( true );
		}
		
		public function add( type:String, loader:Class ):void
		{
			_dict[ type ] = loader;
		}
		
		public function get( type:String ):Class
		{
			return _dict[ type ];
		}
		
		static public function getInstance():FileTypeRegistry
		{
			if( !_instance )
			{
				_instance = new FileTypeRegistry();
			}
			
			return _instance;
		}
		
		static public function initialize():Boolean
		{
  			if( _initialized )
			{
				return false;
			}
			
			var registry:FileTypeRegistry = getInstance();
			
			//start XML file type to Class mapping
			registry.add( "xml", XmlLoader );
			registry.add( "mxml", XmlLoader );
			registry.add( "xsl", XmlLoader );
			registry.add( "xhtml", XmlLoader );
			registry.add( "htm", XmlLoader );
			registry.add( "html", XmlLoader );
			registry.add( "rdf", XmlLoader );
			
			//start text file type to Class mapping
			registry.add( "txt", TextLoader );
			
			//start variables file type to Class mapping
			registry.add( "php", VariableLoader );
			
			//start image file type to Class mapping
			registry.add( "jpg", ImageLoader );
			registry.add( "jpeg", ImageLoader );
			registry.add( "png", ImageLoader );
			registry.add( "gif", ImageLoader );
			
			registry.add( "swf", MovieLoader );
			
			registry.add( "flv", VideoLoader );
			
			//--> H264 :)
			registry.add( "mov", VideoLoader );
			
			return true;
		}
		
		static private var _initialized:Boolean = initialize();		
		
	}
	
}
