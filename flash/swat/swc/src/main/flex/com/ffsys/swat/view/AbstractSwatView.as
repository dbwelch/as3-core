package com.ffsys.swat.view  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.text.TextFieldFactory;
	
	import com.ffsys.utils.collections.strings.StringCollection;
	
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
			
		static private var _textFieldFactory:TextFieldFactory
			= new TextFieldFactory();		
		
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
		* 	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get textFieldFactory():TextFieldFactory
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
		
		/**
		* 	@inheritDoc
		*/
		public function createTextField(
			text:String = "",
			width:Number = 140,
			height:Number = 80,
			font:String = null,
			size:Number = 12,
			color:Number = 0xffffff ):TextField
		{
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.size = size;
			format.color = color;
			format.align = TextFormatAlign.LEFT;
			format.leading = 0;

			var txt:TextField = new TextField();
			txt.width = width;
			txt.height = height;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.defaultTextFormat = format;
			txt.embedFonts = true;
			txt.text = text;
			txt.selectable = false;
			txt.wordWrap = true;

			return txt;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyProperties(
			target:Object, properties:Object ):void
		{
			if( target != null )
			{
				var z:String = null;
				for( z in properties )
				{
					if( target.hasOwnProperty( z ) )
					{
						target[ z ] = properties[ z ];
					}
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFieldProperties(
			txt:TextField, properties:Object ):void
		{
			if( txt != null )
			{
				applyProperties( txt, properties );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFormatProperties(
			txt:TextField, properties:Object ):void
		{
			if( txt != null )
			{
				var tf:TextFormat = txt.defaultTextFormat;
				
				if( tf != null )
				{
					applyProperties( tf, properties );
				}
				
				txt.defaultTextFormat = tf;
				txt.text = txt.text;
			}
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