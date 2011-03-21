package org.flashx.ui.core {
	
	/**
	*	Encapsulates the information for a single rendering
	*	on a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.07.2010
	*/
	
	//TODO: remove this deprecated logic
	public class ComponentRender extends Object
		implements IComponentRender {
		
		private var _component:IComponent;
		private var _phase:String;
		
		/**
		*	Creates a <code>ComponentRender</code> instance.
		*	
		*	@param component The component being rendered.
		*	@param phase The rendering phase for the component.
		*/
		public function ComponentRender(
			component:IComponent = null,
			phase:String = null )
		{
			super();
			_component = component;
			_phase = phase;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get component():IComponent
		{
			return _component;
		}
		
		public function set component( value:IComponent ):void
		{
			_component = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phase():String
		{
			return _phase;
		}
		
		public function set phase( value:String ):void
		{
			_phase = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function render():void
		{
			//trace("ComponentRender::render(), ", component, phase );
			
			if( component )
			{
				switch( phase )
				{
					case RenderPhase.REDRAW:
						//component.redraw();
						break;
				}
			}
		}
	}
}