package com.ffsys.ui.css {
	
	/**
	*	Abstract super class for style strategies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public class AbstractStyleStrategy extends Object
		implements IStyleStrategy {
			
		private var _styleSheet:CssStyleCollection;			
		
		/**
		*	Creates an <code>AbstractStyleStrategy</code> instance.	
		*/
		public function AbstractStyleStrategy()
		{
			super();
		}
		
		/**
		*	Applies styles stored in the style sheet associated with
		*	this strategy to the target style aware object.
		*	
		*	@param target The target to apply styles to.
		*	
		*	@return An array of the styles that were applied. If the
		*	style sheet associated with this strategy is null the returned
		*	array will be null. If no styles were located in the style sheet
		*	this method will return an empty array.	
		*/
		protected function applyStyles( target:IStyleAware ):Array
		{
			var styles:Array = null;
			if( styleSheet )
			{
				styles = styleSheet.apply(
					target.styles, target );
			}
			return styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get styleSheet():CssStyleCollection
		{
			return _styleSheet;
		}
		
		public function set styleSheet( styleSheet:CssStyleCollection ):void
		{
			_styleSheet = styleSheet;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function destroy():void
		{
			_styleSheet = null;
		}				
	}
}