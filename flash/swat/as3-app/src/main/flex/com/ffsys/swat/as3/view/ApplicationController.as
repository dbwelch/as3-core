package com.ffsys.swat.as3.view {
	
	import flash.display.*;
	import flash.filters.BitmapFilter;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import com.ffsys.ui.text.core.*;
	
	import com.ffsys.effects.tween.*;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.xml.IParser;	
	
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.IApplicationMainController;	
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.utils.properties.IMessagesAware;
	import com.ffsys.utils.properties.IProperties;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.controls.*;
	import com.ffsys.ui.data.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.text.*;
	import com.ffsys.ui.runtime.*;
	import com.ffsys.ui.css.*;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ApplicationController extends AbstractApplicationController
		implements 	IApplicationMainController,
		 			IMessagesAware {
			
		private var _stroke:Stroke;
		private var _solidFill:SolidFill;
			
		private var _loader:IRuntimeLoader;
		private var _document:IDocument;
		private var _messages:IProperties;
		
		public var vbox:VerticalBox;
		
		/**
		*	Creates a <code>ApplicationController</code> instance.
		*/
		public function ApplicationController()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function ready(
			parent:IApplication,
			main:IApplicationPreloader,
			runtime:IBootstrapLoader,
			view:IApplicationPreloadView ):Boolean
		{
			var preloader:ApplicationPreloadView
				= ApplicationPreloadView( view );
			createChildren( DisplayObjectContainer( parent ) );
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get messages():IProperties
		{
			return _messages;
		}
		
		public function set messages( value:IProperties ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		private function createChildren( root:DisplayObjectContainer ):void
		{
			//update the style manager reference
			UIComponent.styleManager = styleManager;
			
			vbox = new VerticalBox();
			root.addChild( vbox );
			
			trace("ApplicationController::createChildren()", "GOT APPLICATION BEAN: ",
				getBean( "application" ), Object( messages ).common.message );
			
			/*
			var rect:RectangleGraphic = RectangleGraphic( styleManager.getStyle( "rectangle" ) );

			var graphic:Graphic = new Graphic( rect );
			vbox.addChild( graphic );
			
			trace("ApplicationController::createChildren()", rect, rect.fill, rect.stroke, rect.width, rect.height, rect.preferredWidth, rect.preferredHeight );			
			
			return;
			*/
			
			var substyle:Object = styleManager.getStyle( "sub" );
			trace("ApplicationController::createChildren()", substyle.substitution );			
			
			/*
			var data:Array = [ "apples", "oranges", "pears" ];
			
			var listBinding:DataBindingCollection = new DataBindingCollection();
			for( var i:int = 0;i < data.length;i++ )
			{
				listBinding.children.push( new StringDataBinding( data[ i ] ) );
			}
		
			var list:List = new List();
			list.dataBinding = listBinding;
			vbox.addChild( list );
			listBinding.children[ 0 ].data = "THIS IS A VALUE";
			*/
			
			var proxy:IDataBindingProxy = null;
			var lbl:IDataBinding = null;
			var icon:IDataBinding = null;
			var sprite:Shape = null;
			
			var data:Array = [
				{ label: "apples", colour: 0x00ff00},
				{ label: "oranges", colour: 0xff6600},
				{ label: "plums", colour: 0x6f0988 } ];
			
			var listBinding:DataBindingCollection = new DataBindingCollection();
			for( var i:int = 0;i < data.length;i++ )
			{
				sprite = new Shape();
				sprite.graphics.beginFill( data[ i ].colour, 1 );
				sprite.graphics.drawRect( 0, 0, 10, 10 );
				sprite.graphics.endFill();
				
				lbl = new StringDataBinding( data[ i ].label );
				icon = new DisplayObjectDataBinding( sprite );
				proxy = new DataBindingProxy();
				proxy.addDataBinding( lbl );
				proxy.addDataBinding( icon );
				
				//TODO: move to an addDataBinding implementation
				listBinding.children.push( proxy );
			}
			
			var list:List = new List();
			list.itemRendererClass = IconLabelListItemRenderer;
			list.dataBinding = listBinding;
			vbox.addChild( list );
			
			/*
			_loader = new RuntimeLoader();
			
			_loader.getLoaderQueue(
					new URLRequest( "view.xml" ),
					vbox,
					{ title: "this is a test" },
					{ another: "another title :)" },
					{ items: [ 1, 2, 3 ] },
					{ locales: configuration.locales.getLocales(), fonts: Font.enumerateFonts() }
				);
			
			_document = _loader.document;
			
			trace("ApplicationController::createChildren()", _document, _document.id );
			
			_loader.addEventListener( LoadEvent.LOAD_COMPLETE, runtimeLoaded );
			_loader.load();
			*/
			
			_document = IRuntimeParser( getViewParser() ).runtime;
			
			var view:DisplayObject = getView(
				"view",
				{ title: "this is a test" },
				{ another: "another title :)" },
				{ items: [ 1, 2, 3 ] },
				{ locales: configuration.locales.getLocales(), fonts: Font.enumerateFonts() } );
				
			trace("ApplicationController::createChildren() GOT VIEW", view );
			
			if( view != null )
			{
			
				trace("ApplicationController::createChildren()", _document, _document.identifiers );
				
				vbox.addChild( view );
				runtimeLoaded();
			}
		}
		
		public function set myPreloaderView(value:Object):void
		{
			trace("DefaultApplication::set myLocales()",  "SET MY PRELOADER VIEW: " , value );
		}		
		
		public function set myLocale(value:Object):void
		{
			trace("DefaultApplication::set myLocales()",  "SET MY LOCALE: " , value, configuration );
		}		
		
		private function runtimeLoaded():void
		{
			var btn:Button = Button( _document.getElementById( "btn" ) );
			
			trace("ApplicationController::runtimeLoaded()", btn );
			
			btn.addEventListener( MouseEvent.CLICK, click );
			
			trace("ApplicationController::runtimeLoaded(), ", btn );
			
			var graphic:Graphic = Graphic( _document.getElementById( "graphic" ) );
			
			trace("ApplicationController::runtimeLoaded()", "GOT GRAPHIC", graphic );
			
			var tween:ITween = ITween( getStyle( "alpha-tween" ) );
			tween.target = graphic;
			tween.initialize();
			tween.start();
			
			trace("ApplicationController::runtimeLoaded() GOT TWEEN", tween );		
		}
		
		private function click( event:MouseEvent ):void
		{
			trace("ApplicationController::click()", Button( event.target ).text );
		}
		
	}
}