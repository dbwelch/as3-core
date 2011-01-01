package com.ffsys.ui.suite.core {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	
	import com.ffsys.color.*;
	
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.IApplicationMainController;
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.runtime.*;
	import com.ffsys.ui.text.*;	
	import com.ffsys.ui.tooltips.*;
	
	import com.ffsys.ui.suite.view.*;
	
	/**
	*	The main controller for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ComponentSuiteController extends AbstractApplicationController
		implements IApplicationMainController {
			
		/**
		* 	The identifier of the navigation view.
		*/
		public static const NAVIGATION_ID:String = "navigation";
		
		/**
		* 	The identifier of the content view.
		*/
		public static const CONTENT_ID:String = "content";		
		
		/**
		* 	The identifier of the images view.
		*/
		public static const IMAGES_ID:String = "images";
		
		/**
		* 	The identifier of the containers view.
		*/
		public static const CONTAINERS_ID:String = "containers";
			
		public var vbox:VerticalBox;
		
		public var navigation:IDocument;
		public var content:IDocument;
		
		private var _view:String;
		private var _views:Object = new Object();
		
		/**
		*	Creates a <code>ComponentSuiteController</code> instance.
		*/
		public function ComponentSuiteController()
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
			//UIComponent.styleManager = styleManager;
			
			//create the main view
			createMainChildren( DisplayObjectContainer( parent ) );
			return true;
		}
		
		/**
		* 	@private
		*/
		private function doWithNavigationLinks( links:Vector.<DisplayObject> ):void
		{
			if( links != null )
			{
				var link:DisplayObject = null;
				for each( link in links )
				{
					link.addEventListener( MouseEvent.CLICK, navigationLinkClick );
				}
			}
		}
		
		private function handleImagesInjection( view:IDocument ):void
		{
			var candidates:Vector.<DisplayObject> = view.getElementsByMatch( /^injected-images/ );
			var display:DisplayObject = null;
			var collection:IImageContainer = null;
			for each( display in candidates )
			{
				collection = display as IImageContainer;

				if( collection != null
					&& collection.numChildren == 0 )
				{
					var images:Vector.<DisplayObject> = new Vector.<DisplayObject>();
					images.push( getImage( "thumbnail001" ) );
					images.push( getImage( "thumbnail002" ) );
					collection.inject( images );
				}				
			}
		}
		
		private function handleContainerClick( event:MouseEvent ):void
		{
			trace("ComponentSuiteController::handleContainerClick()", event.target, event.currentTarget, event.target.id );
			
			var container:IContainer = event.target.parent as IContainer;
			
			trace("ComponentSuiteController::handleContainerClick()", container, container.id );
			
			if( container != null )
			{
				var result:Label = _views[ CONTAINERS_ID ].getElementById(
					container.id + "-result" ) as Label;
					
				if( result != null )
				{
					var key:String = ( container is ISelectableContainer )
						? "you.selected" : "you.clicked";
						
					trace("ComponentSuiteController::handleContainerClick()", event.target.text );
						
					result.text = getMessage( key, event.target.text );
				}
			}
		}
		
		private function handleContainerExamples( view:IDocument ):void
		{
			var candidates:Vector.<DisplayObject> = view.getElementsByMatch( /^example\-/ );
			
			trace("ComponentSuiteController::handleContainerExamples()", candidates );
			var display:DisplayObject = null;
			for each( display in candidates )
			{
				display.addEventListener( MouseEvent.CLICK, handleContainerClick );
			}
			
			/*
			var display:DisplayObject = null;
			var collection:IImageContainer = null;
			for each( display in candidates )
			{
				collection = display as IImageContainer;

				if( collection != null
					&& collection.numChildren == 0 )
				{
					var images:Vector.<DisplayObject> = new Vector.<DisplayObject>();
					images.push( getImage( "thumbnail001" ) );
					images.push( getImage( "thumbnail002" ) );
					collection.inject( images );
				}				
			}
			*/
		}		
		
		/**
		* 	@private
		*/
		private function navigationLinkClick( event:MouseEvent ):void
		{
			if( event.target is IComponent )
			{
				//the view id
				var id:String = IComponent( event.target ).customData as String;
				
				if( _view != null
					&& id == _view )
				{
					return;
				}
				
				var view:DisplayObject = _views[ id ];
				
				if( view == null )
				{
					view = getView( id );
				}
				
				if( view == null )
				{
					throw new Error( "Could not find view component for identifier '"
					 	+ id + "'.");
				}
				
				if( id == IMAGES_ID )
				{
					handleImagesInjection( view as IDocument );
				}
				
				if( id == CONTAINERS_ID )
				{
					handleContainerExamples( view as IDocument );
				}
				
				trace("ComponentSuiteController::navigationLinkClick()", view );
				
				content.removeAllChildren();
				content.addChild( DisplayObject( view ) );
				
				/*
				var c:RgbColor = new RgbColor( 255, 128, 0 );
				//c.rgb( 255, 128, 0 );
				
				//36 / 1 / 1
				
				//var h:HslColor = new HslColor( 36, 1, 1 );
				
				var h:HslColor = new HslColor();
				h.hue = 36;
				h.saturation = 1;
				h.luminosity = 1;
				
				view.transform.colorTransform = c;
				*/
				
				/*
					var c:RgbColor = new RgbColor( 255, 128, 0 );
					c.tint( 0xff0000, 0.5 );
					view.transform.colorTransform = c;
				*/
				
				/*
					var h:HslColor = new HslColor( 36, 1, 1 );
					h.tint( 0xff0000, 0.5 );
					view.transform.colorTransform = h;
				*/
				
				_views[ id ] = view;
				_view = id;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
 		private function createMainChildren( root:DisplayObjectContainer ):void
		{	
			/*
			trace("ComponentSuiteController::createChildren(), creating initial vertical box: ",
				this, UIComponent.utilities, UIComponent.utilities.layer, UIComponent.utilities.layer.tooltips );
			*/
			
			vbox = new VerticalBox();			
			root.addChild( vbox );
			
			//initialize the tooltips
			var tooltip:DefaultToolTipRenderer = new DefaultToolTipRenderer()
			tooltip.maximumTextWidth = 200;
			
			//UIComponent.utilities.layer.tooltips.delay = 1000;
			UIComponent.utilities.layer.tooltips.renderer = tooltip;			
			
			navigation = getView( NAVIGATION_ID ) as IDocument;

			if( navigation != null )
			{	
				doWithNavigationLinks(
					navigation.getElementsByMatch( /\-link$/ ) );
				vbox.addChild( DisplayObject( navigation ) );
			}
			
			content = getView( CONTENT_ID ) as IDocument;
			if( content != null )
			{	
				vbox.addChild( DisplayObject( content ) );
			}			
			
			/*
			var view:DisplayObject = getView( "graphics" );
			
			if( view != null && document != null )
			{
				vbox.addChild( view );
			}
			*/
			
			/*
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );		
			graphicsSuite.y += 350;
			*/
			
			/*
			var loadersSuite:LoadersSuite = new LoadersSuite();
			vbox.addChild( loadersSuite );
			
			var buttonSuite:ButtonSuite = new ButtonSuite();
			vbox.addChild( buttonSuite );
	
			var containersSuite:ContainersSuite = new ContainersSuite();
			vbox.addChild( containersSuite );
			
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );
			
			var textSuite:TextSuite = new TextSuite();
			vbox.addChild( textSuite );
			*/
		}
	}
}