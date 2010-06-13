package com.ffsys.swat.configuration {
	
	import flash.display.DisplayObject;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;

	/**
	*	Utility class for accessing loaded assets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class AssetManager extends Object
		implements IConfigurationAware {
		
		private var _configuration:IConfiguration;
		
		/**
		*	Creates an <code>AssetManager</code> instance.
		* 
		* 	@param configuration The application configuration.
		*/
		public function AssetManager( configuration:IConfiguration = null )
		{
			super();
			this.configuration = configuration;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
		}
		
		/**
		*	Gets an asset from the loaded assets movie based on the
		*	identifier.
		*	
		*	@param id The identifier for the asset.
		*	
		*	@return An instance of the asset.	
		*/
		public function getAssetById( id:String, list:String = null ):DisplayObject
		{
			var classPath:String = null;
			
			if( !configuration || !configuration.assets )
			{
				throw new Error( "Cannot get an asset with null asset data." );
			}
			
			try
			{
				classPath = this.configuration.assets.getStringById( id, list );
			}catch( e:Error )
			{
				throw new Error( "Could not find asset class path with id '" + id + "'" );
			}
			
			return DisplayObject( getAssetByClassPath( classPath ) );
		}
		
		/**
		*	Gets an asset from the loaded assets movie based on a
		*	class path.
		*	
		*	@param classPath The class path for the asset.
		*	
		*	@return An instance of the asset.
		*/		
		public function getAssetByClassPath(
			classPath:String ):Object
		{
			var clz:Class = null;
			var instance:Object = null;
			
			try
			{
				clz = Class( getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate a class for class path '" + classPath + "'" );
			}
			
			try
			{
				instance = new clz();
			}catch( e:Error )
			{
				throw new Error(
					"Could not instantiate an instance for class path '" + classPath + "'" );
			}
			
			return instance;	
		}
		
		public function getSoundByClassPath( classPath:String ):Sound
		{
			return Sound( getAssetByClassPath( classPath ) );
		}
		
		public function playSoundByClassPath(
			classPath:String,
			startTime:Number = 0,
			loops:int = 0,
			transform:SoundTransform = null ):SoundChannel
		{
			var snd:Sound = getSoundByClassPath( classPath );
			var channel:SoundChannel =	snd.play(
				startTime, loops, transform );
			return channel;
		}
	}
}