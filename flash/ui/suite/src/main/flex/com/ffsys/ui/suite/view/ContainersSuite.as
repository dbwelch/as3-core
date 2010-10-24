package com.ffsys.ui.suite.view {
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import com.ffsys.ui.buttons.*;	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.common.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.scrollbars.*;
	import com.ffsys.ui.text.*;
	
	import com.ffsys.utils.random.RandomUtils;
	
	/**
	*	Represents a view for the containers functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class ContainersSuite extends AbstractComponentSuiteView {
		
		public var hbox:HorizontalBox;
		
		/**
		*	Creates a <code>ContainersSuite</code> instance.	
		*/
		public function ContainersSuite()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			createHeading( "Containers Suite (com.ffsys.ui.containers)" );
			
			var hbox:HorizontalBox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			var vscrollTarget:Graphic =
				new Graphic(
					new RectangleGraphic(
						100, 200,
						null,
						new SolidFill( 0xff6600 ) ) );
			
			hbox.addChild( vscrollTarget );
				
			var vscroll:VerticalScrollBar = new VerticalScrollBar(
				vscrollTarget );
			hbox.addChild( vscroll );
			
			vscroll.setSize( 16, 150 );
			
			var scrollVBox:VerticalBox = new VerticalBox();
			scrollVBox.spacing = 10;
			hbox.addChild( scrollVBox );
			
			var hscrollTarget:Graphic =
				new Graphic(
					new RectangleGraphic(
						200, 100,
						null,
						new SolidFill( 0xff0066 ) ) );
			
			scrollVBox.addChild( hscrollTarget );
				
			var hscroll:HorizontalScrollBar = new HorizontalScrollBar(
				hscrollTarget );
			scrollVBox.addChild( hscroll );
			
			hscroll.setSize( 150, 16 );
			
			//hscroll.enabled = false;
			
			var lbl:Label = null;	
			
			var cell:Cell = new Cell( 80, 80 );
			cell.paddings.padding = 5;
			cell.margins.margin = 5;
			cell.background = new RectangleGraphic(
				cell.preferredWidth,
				cell.preferredHeight,
				null, new SolidFill( 0xa9a9a9 ) );
				
			lbl = new Label( "Box Model" );
			lbl.color = 0x000000;
			cell.addChild( lbl );
			cell.addChild( new BoxModelComponent() );
			hbox.addChild( cell );
			
			cell = new Cell( 80, 80 );
			cell.paddings.padding = 5;
			cell.margins.margin = 5;
			cell.background = new RectangleGraphic(
				cell.preferredWidth,
				cell.preferredHeight,
				null, new SolidFill( 0xa9a9a9 ) );
				
			lbl = new Label( "Box Model" );
			lbl.color = 0x000000;
			cell.layout.horizontalAlign = Orientation.LEFT;
			cell.layout.verticalAlign = Orientation.TOP;
			cell.addChild( lbl );
			cell.addChild( new BoxModelComponent() );
			hbox.addChild( cell );
			
			cell = new Cell( 80, 80 );
			cell.paddings.padding = 5;
			cell.margins.margin = 5;
			cell.background = new RectangleGraphic(
				cell.preferredWidth,
				cell.preferredHeight,
				null, new SolidFill( 0xa9a9a9 ) );
				
			lbl = new Label( "Box Model" );
			lbl.color = 0x000000;
			cell.layout.horizontalAlign = Orientation.RIGHT;
			cell.layout.verticalAlign = Orientation.TOP;
			cell.addChild( lbl );
			cell.addChild( new BoxModelComponent() );
			hbox.addChild( cell );
			
			cell = new Cell( 80, 80 );
			cell.paddings.padding = 5;
			cell.margins.margin = 5;
			cell.background = new RectangleGraphic(
				cell.preferredWidth,
				cell.preferredHeight,
				null, new SolidFill( 0xa9a9a9 ) );
				
			lbl = new Label( "Box Model" );
			lbl.color = 0x000000;
			cell.layout.horizontalAlign = Orientation.RIGHT;
			cell.layout.verticalAlign = Orientation.BOTTOM;
			cell.addChild( lbl );
			cell.addChild( new BoxModelComponent() );
			hbox.addChild( cell );
			
			cell = new Cell( 80, 80 );
			cell.paddings.padding = 5;
			cell.margins.margin = 5;
			cell.background = new RectangleGraphic(
				cell.preferredWidth,
				cell.preferredHeight,
				null, new SolidFill( 0xa9a9a9 ) );
				
			lbl = new Label( "Box Model" );
			lbl.color = 0x000000;
			cell.layout.horizontalAlign = Orientation.LEFT;
			cell.layout.verticalAlign = Orientation.BOTTOM;
			cell.addChild( lbl );
			cell.addChild( new BoxModelComponent() );
			hbox.addChild( cell );			
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			var addButton:TextButton = new TextButton( "Add component" );
			var removeButton:TextButton = new TextButton( "Remove component" );
			
			hbox.addChild( addButton );
			hbox.addChild( removeButton );
			
			this.hbox = new HorizontalBox();
			this.hbox.spacing = 5;
			this.hbox.addChild( DisplayObject( getItem() ) );
			addChild( this.hbox );
			
			addButton.addEventListener( MouseEvent.MOUSE_UP, addHBoxItem );
			removeButton.addEventListener( MouseEvent.MOUSE_UP, removeHBoxItem );
		}
		
		private function getItem():IComponent
		{
			var component:IComponent = new Graphic(
				new SquareGraphic( 10, null,
					new SolidFill( 0xff0000, 0.5 ) ) );
			component.name = "GraphicItem" + hbox.numChildren + 1;
			return component;
		}
		
		private function addHBoxItem( event:MouseEvent ):void
		{
			var item:IComponent = getItem();
			hbox.addChild( DisplayObject( item ) );
		}
		
		private function removeHBoxItem( event:MouseEvent ):void
		{
			if( hbox && hbox.numChildren > 0 )
			{
				var index:int = RandomUtils.getRandomInteger(
					0, hbox.numChildren - 1 );
				
				index = 0;	
				
				var child:DisplayObject = hbox.getChildAt( index );
				trace("ContainersSuite::removeHBoxItem(), ", hbox.numChildren, child, index );
				hbox.removeChild( child );
			}
		}
	}
}