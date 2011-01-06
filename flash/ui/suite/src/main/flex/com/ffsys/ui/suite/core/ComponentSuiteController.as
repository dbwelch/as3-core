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
		
		/**
		* 	The identifier of the buttons view.
		*/
		public static const BUTTONS_ID:String = "buttons";
		
		/**
		* 	A custom instance name for the root document view.
		*/
		public static const DOCUMENT_NAME:String = "uiComponentSuite";
			
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
				
				var document:IDocument = IDocument( view );
				
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
					var heading:IComponent = document.getElementById(
						"page-package-heading" ) as IComponent;
					
					var newHeading:IComponent = heading.copy( true );
					var container:VerticalBox = document.getElementById(
						"text-buttons" ) as VerticalBox;
					container.addChild( DisplayObject( newHeading ) );
					//container.update();
					
					/*
					trace( "Document xml component circular reference: ", document.xml.component, radioButtonGroup, radioButtonGroup.component );
					
					if( radioButtonGroup.component )
					{
						trace("ComponentSuiteController::navigationLinkClick()", "GOT XML COMPONENT REFERENCE!!!!",
							radioButtonGroup.component.toString() );
					}
					*/
					
					//radioButtonGroup.debug();
					
					var btn:IButton = document.getElementById(
						"toggle-button" ) as IButton;
					
					//trace("ComponentSuiteController::navigationLinkClick()", btn );
					
					if( btn != null )
					{
						var result:Object = btn.setStyle( { color: 0xff0000 } );
						
						/*
						trace("ComponentSuiteController::navigationLinkClick()",
							0xff0000, result, result.color, result.color == 0xff0000 );
						*/
					}
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
			var document:IDocument = new Document();
			document.name = DOCUMENT_NAME;
			document.preferredWidth = root.stage.stageWidth;
			document.preferredHeight = root.stage.stageHeight;
			
			root.addChild( DisplayObject( document ) );
			
			vbox = new VerticalBox();						
			document.addChild( vbox );
			
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
			
			vbox.update();
		}
	}
}

/*
dynamic final class TestExpando extends Object {
	
}
*/