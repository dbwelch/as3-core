package org.flashx.ui.display
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	import org.flashx.ui.buttons.ButtonComponent;
	import org.flashx.ui.data.*;
	
	/**
	*	Represents a component that adds a display list object
	* 	at runtime based on a fully qualified class path or
	* 	instance reference.
	* 
	* 	These instances may be interactive (receive mouse events)
	* 	but are not interactive by default.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class RuntimeAsset extends ButtonComponent
	{
		private var _classPath:String;
		private var _asset:DisplayObject;
		
		/**
		* 	Creates an <code>RuntimeAsset</code> instance.
		* 
		* 	@param classPath The fully qualified class path to the
		* 	display object asset.
		*/
		public function RuntimeAsset( classPath:String = null )
		{
			super();
			if( classPath != null )
			{
				this.classPath = classPath;
			}
			this.interactive = false;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function notify( notification:IDataBindingNotification ):void
		{
			//trace("RuntimeAsset::notify()", notification, this, dataBinding );
			if( ( notification is ChangeNotification || notification is CreateNotification )
				&& ( this.dataBinding is DisplayObjectDataBinding ) )
			{
				this.asset = DisplayObjectDataBinding( this.dataBinding ).value;
			}
		}
		
		/**
		* 	The class path to the runtime asset.
		*/
		public function get classPath():String
		{
			return _classPath;
		}
		
		public function set classPath( classPath:String ):void
		{
			_classPath = classPath;

			if( _asset == null
			 	&& this.classPath != null )
			{
				this.asset = getRuntimeDisplayObject( this.classPath );
			}
		}
		
		/**
		* 	The runtime asset as a display object.
		*/
		public function get asset():DisplayObject
		{
			return _asset;
		}
		
		public function set asset( asset:DisplayObject ):void
		{
			if( _asset != null
				&& contains( _asset ) )
			{
				removeChild( _asset );
			}
			
			_asset = asset;
			
			if( _asset != null
				&& _classPath == null )
			{
				//keep the class path in sync when the asset
				//is set directly
				_classPath = getQualifiedClassName( _asset );
			}
			
			if( _asset == null
				&& _classPath )
			{
				_classPath = null;
			}
			
			if( _asset != null
			 	&& !contains( _asset ) )
			{
				addChild( _asset );
			}
		}
		
		/**
		* 	Cleans composite references.
		*/
		override public function destroy():void
		{
			super.destroy();
			_classPath = null;
			_asset = null;
		}
	}
}