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

	import com.ffsys.ui.buttons.*;	
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.dom.*;
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
		
		/**
		* 	The identifier of the buttons view.
		*/
		public static const BUTTONS_ID:String = "buttons";
		
		/**
		* 	A custom instance name for the root document view.
		*/
		public static const DOCUMENT_NAME:String = "uiComponentSuite";
		
		public var main:IDomDocument;
		public var content:BlockElement;		
			
		//
		public var vbox:VerticalBox;
		public var navigation:IDomDocument;
		
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
					trace("ComponentSuiteController::doWithNavigationLinks()", "DO WITH NAV LINK", link, Object( link ).customData );
					link.addEventListener(
						MouseEvent.CLICK, navigationLinkClick );
				}
			}
		}
		
		private function handleImagesInjection( view:IDomDocument ):void
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
		
		private function handleContainerExamples( view:IDomDocument ):void
		{
			var candidates:Vector.<DisplayObject> = view.getElementsByMatch( /^example\-/ );
			
			trace("ComponentSuiteController::handleContainerExamples()", candidates );
			var display:DisplayObject = null;
			for each( display in candidates )
			{
				display.addEventListener( MouseEvent.CLICK, handleContainerClick );
			}
		}
		
		/**
		* 	@private
		*/
		private function navigationLinkClick( event:MouseEvent ):void
		{
			//event.preventDefault();
			
			trace("ComponentSuiteController::navigationLinkClick()", IComponent( event.target ).id );
			
			if( event.target is IComponent && IComponent( event.target ).id is String )
			{
				//the view id
				var id:String = IComponent( event.target ).id.replace( /\-link$/, "" );
				
				trace("ComponentSuiteController::navigationLinkClick() GOT VIEW ID: ", id );
				
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
				
				var document:IDomDocument = IDomDocument( view );
				
				if( view == null )
				{
					throw new Error( "Could not find view component for identifier '"
					 	+ id + "'.");
				}
				
				if( id == IMAGES_ID )
				{
					handleImagesInjection( view as IDomDocument );
				}
				
				if( id == CONTAINERS_ID )
				{
					handleContainerExamples( view as IDomDocument );
				}

				content.removeAllChildren();
				content.addChild( DisplayObject( view ) );
				
				/*
				trace("ComponentSuiteController::navigationLinkClick()",
					document, document.xml, document.xml.component );
				*/
				
				/*
				var ex:TestExpando = new TestExpando();
				ex.debug = function():void
				{
					trace("ComponentSuiteController::navigationLinkClick()", "expando debug", this );
				}
				*/
				
				//ex.debug();
					
				if( id == BUTTONS_ID )
				{
					
					/*
					var heading:IComponent = document.getElementById(
						"page-package-heading" ) as IComponent;
					
					var newHeading:IComponent = heading.copy();
					var container:VerticalBox = document.getElementById(
						"text-buttons" ) as VerticalBox;
					container.addChild( DisplayObject( newHeading ) );
					//container.update();
					
					//radioButtonGroup.debug();
					
					var btn:IButton = document.getElementById(
						"filter-toggle-button" ) as IButton;
					
					//trace("ComponentSuiteController::navigationLinkClick()", btn );
					
					if( btn != null )
					{
						var result:Object = btn.setStyle( { color: 0xff0000 } );
						
						//trace("ComponentSuiteController::navigationLinkClick()",
						//	0xff0000, result, result.color, result.color == 0xff0000 );
					}
					
					var newButton:IButton = btn.clone() as IButton;
					container.addChild( DisplayObject( newButton ) );
					*/
				}

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
			var document:IDomDocument = new Document();
			document.id = DOCUMENT_NAME;

			vbox = new VerticalBox();
			document.addChild( vbox );
			//vbox.finalized();
			*/
			
			/*
			navigation = getView( NAVIGATION_ID ) as IDomDocument;

			if( navigation != null )
			{	
				doWithNavigationLinks(
					navigation.getElementsByMatch( /\-link$/ ) );
				vbox.addChild( DisplayObject( navigation ) );
			}
			
			content = getView( CONTENT_ID ) as IDomDocument;
			if( content != null )
			{
				vbox.addChild( DisplayObject( content ) );
			}
			
			root.addChild( DisplayObject( document ) );
			
			//top level document box model
			var docBoxModel:BoxModelComponent = BoxModelComponent(
				navigation.getComponentBean(
					ComponentIdentifiers.BOX_MODEL ) );
			vbox.addChild( docBoxModel );
			docBoxModel.target = document;
			
			//TODO: refactor the entire tooltip logic
			//initialize the tooltips
			var tooltip:DefaultToolTipRenderer = new DefaultToolTipRenderer()
			tooltip.maximumTextWidth = 200;
			
			//UIComponent.utilities.layer.tooltips.delay = 1000;
			UIComponent.utilities.layer.tooltips.renderer = tooltip;
			*/
			
			main = getView( "global" ) as IDomDocument;
			if( main != null )
			{
				trace("[ADDING ROOT VIEW] ComponentSuiteController::createMainChildren()", root, main );
				
				root.addChild( DisplayObject( main ) );
				
				var z:String = null;
				
				for( z in main )
				{
					trace("ComponentSuiteController::createMainChildren() GOT DOCUMENT ELEMENT: ", z, main[ z ] );
				}
				
				//TODO: re-integrate
				
				doWithNavigationLinks(
					main.getElementsByMatch( /\-link$/ ) );
					
				content = main.getElementById( CONTENT_ID ) as BlockElement;
				
				//trace("ComponentSuiteController::createMainChildren() CONTENT: ", main.getElementById( CONTENT_ID ) );
				//content = main.getElementById( CONTENT_ID ) as BlockElement;
				
				//trace("::::::::::::::>>>>>>>>>>>>>>>>>>>>>> ComponentSuiteController::createMainChildren() GOT GLOBAL VIEW:: ", main, main.head, main.body, content );
				
				
				/*
				var p:Object = main.getElementById( "test-href" ) as Object;
				
				trace("::::::::::::::>>>>>>>>>>>>>>>>>>>>>> ComponentSuiteController::createMainChildren() GOT TEST P:: ", p, p.text, p.getStyleCache().main, p.getStyleCache().main.font, p.getStyleCache().main.color, p.parent, p.width, p.height );
				*/
				
				
				//main.finalized();
			}
		}
	}
}

/*
dynamic final class TestExpando extends Object {
	
}
*/