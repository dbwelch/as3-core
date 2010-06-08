package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import com.ffsys.swat.configuration.AssetManager;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.IConfigurationAware;
	import com.ffsys.swat.configuration.Settings;
	
	/**
	*	Abstract super class for application views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class AbstractSwatView extends Sprite
		implements IApplicationView {
		
		private var _configuration:IConfiguration;
		private var _enabled:Boolean = true;
		
		/**
		*	Creates an <code>AbstractSwatView</code> instance.
		*/
		public function AbstractSwatView()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createChildren():void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		* 	Sets the application configuration data.
		* 
		* 	@param configuration The configuration data.
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
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
		* 	Adds a child display list instance to this instance.
		* 
		* 	@param child The child display object.
		*/
		override public function addChild( child:DisplayObject ):DisplayObject
		{
			if( child is IConfigurationAware )
			{
				IConfigurationAware( child ).configuration = this.configuration;
			}
			
			super.addChild( child );
			
			if( child is IApplicationView )
			{
				IApplicationView( child ).createChildren();
			}
			
			return child;
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set enabled( enabled:Boolean ):void
		{
			_enabled = enabled;
			
			this.mouseEnabled = enabled;
			this.mouseChildren = enabled;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeAllChildren():void
		{
			var child:DisplayObject = null;
			for( var i:int = 0;i < numChildren;i++ )
			{
				child = getChildAt( i );
				removeChild( child );
				i--;
			}
		}
	}
}