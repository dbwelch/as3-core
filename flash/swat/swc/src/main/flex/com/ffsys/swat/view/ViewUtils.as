package com.ffsys.swat.view  {
	
	import flash.filters.BitmapFilter;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.text.ITextFieldFactory;
	import com.ffsys.ui.text.TextFieldFactory;
	
	import com.ffsys.utils.collections.strings.StringCollection;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.Settings;
	import com.ffsys.swat.configuration.filters.IFilterCollection;
	
	/**
	*	Encapsulates access to various commonly used configuration
	*	properties and other utility functionality such as a textfield
	*	factory to simplify the process of creating textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ViewUtils extends Object
		implements IViewUtils {
			
		static private var _textFieldFactory:ITextFieldFactory
			= new TextFieldFactory();		
		
		private var _configuration:IConfiguration;
		
		/**
		*	Creates an <code>ViewUtils</code> instance.
		*/
		public function ViewUtils()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get textFieldFactory():ITextFieldFactory
		{
			return _textFieldFactory;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			if( this.configuration == null )
			{
				throw new Error( "Cannot access the flash variables with a null configuration." );
			}
			
			return this.configuration.flashvars;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get assetManager():AssetManager
		{
			if( this.configuration == null )
			{
				throw new Error( "Cannot access the asset manager with a null configuration." );
			}
			
			return this.configuration.assetManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get settings():Settings
		{
			if( this.configuration == null )
			{
				throw new Error( "Cannot access the application settings with a null configuration." );
			}
			
			return this.configuration.settings;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get assets():StringCollection
		{
			if( this.configuration == null )
			{
				throw new Error( "Cannot access the application assets with a null configuration." );
			}
			
			return this.configuration.assets;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get filters():IFilterCollection
		{
			if( this.configuration == null )
			{
				throw new Error( "Cannot access the application filters with a null configuration." );
			}
			
			return this.configuration.filters;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilterById( id:String ):BitmapFilter
		{
			return this.filters.getFilterById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function registerFont( classPath:String ):Font
		{
			var instance:Object = null;
			
			var clz:Class = null;

			try
			{
				clz = Class( getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error( "Could not find a class for font class '" + classPath + "'." );
			}
			
			try
			{
				instance = new clz();
			}catch( e:Error )
			{
				throw new Error( "Could not instantiate font instance with class path '" + classPath + "'." );
			}
			
			if( !( instance is Font ) )
			{
				throw new Error( "Instantiated instance from class path '" + classPath + "' is not a font." );
			}

			Font.registerFont( clz );
			return Font( instance );
		}
	}
}