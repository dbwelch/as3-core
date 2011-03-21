package org.flashx.ui.core {
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	*	Responsible for the rendering of components
	*	at the last possible moment.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.07.2010
	*/
	public class ComponentRenderer extends EventDispatcher
		implements IComponentRenderer {
		
		private var _stage:Stage;
		private var _targets:Vector.<IComponentRender> = new Vector.<IComponentRender>();
		
		/**
		*	Creates a <code>ComponentRenderer</code> instance.
		*	
		*	@param stage The stage for the application.
		*/
		public function ComponentRenderer( stage:Stage )
		{
			super();
			_stage = stage;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function invalidate(
			renderer:IComponentRender ):void
		{
			if( !stage )
			{
				throw new Error( "Cannot invalidate with a null stage." );
			}
			
			if( renderer == null )
			{
				throw new Error( "Cannot render a null component render target." );
			}
			
			stage.invalidate();
			
			stage.removeEventListener( Event.RENDER, render );
			stage.addEventListener( Event.RENDER, render );
			
			/*
			trace("ComponentRenderer::invalidate(), ",
				renderer, stage.hasEventListener( Event.RENDER ) );
			*/
			var existing:IComponentRender = null;
			var target:IComponentRender = null;
			
			for each( target in _targets )
			{
				if( target.component == renderer.component
				 	&& target.phase == renderer.phase )
				{
					existing = target;
					break;
				}
			}
			
			if( !existing )
			{
				_targets.push( renderer );
			}else{
				//TODO: copy properties into existing render routine
			}
		}
		
		/**
		*	@private	
		*/
		private function render( event:Event ):void
		{
			stage.removeEventListener( Event.RENDER, render );
			
			//trace("ComponentRenderer::render(), ", this );
			
			var target:IComponentRender = _targets.shift();
			while( target )
			{
				target.render();
				target = _targets.shift();
			}
			
			//trace("ComponentRenderer::render(), ", _targets.length );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get stage():Stage
		{
			return _stage;
		}
	}
}