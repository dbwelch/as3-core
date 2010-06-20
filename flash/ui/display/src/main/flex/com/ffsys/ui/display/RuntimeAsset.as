package com.ffsys.ui.display
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.ui.core.InteractiveComponent;
	
	/**
	*	Represents a component that adds a display list object
	* 	at runtime based on a fully qualified class path.
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
	public class RuntimeAsset extends InteractiveComponent
	{
		private var _classPath:String;
		private var _asset:DisplayObject;
		
		/**
		* 	Creates an <code>RuntimeAsset</code> instance.
		* 
		* 	@param classPath The fully qualified class path to the
		* 	display object asset.
		*/
		public function RuntimeAsset( classPath:String )
		{
			super();
			this.classPath = classPath;
			this.interactive = false;
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
			
			if( !_asset )
			{
				_asset = getRuntimeDisplayObject( classPath );
				replaceAsset( _asset );
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
			_asset = asset;
			
			if( _asset && !_classPath )
			{
				//keep the class path in sync when the asset
				//is set directly
				_classPath = getQualifiedClassName( _asset );
			}
			
			if( !_asset && _classPath )
			{
				_classPath = null;
			}
			
			replaceAsset( _asset );
		}
		
		/**
		* 	Sets the asset as a child of this instance.
		* 
		* 	If an existing asset exists and is on the display
		* 	list it is removed.
		* 
		* 	@param asset The asset to add as a child of this instance.
		*/
		private function replaceAsset( asset:DisplayObject ):void
		{
			if( this.asset && contains( this.asset ) )
			{
				removeChild( this.asset );
			}
			
			if( asset )
			{
				addChild( asset );
			}
		}
	}
}