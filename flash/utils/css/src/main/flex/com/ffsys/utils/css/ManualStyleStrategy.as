package com.ffsys.utils.css {
	
	/**
	*	Represents a style strategy where the styles are applied manually.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.10.2010
	*/
	public class ManualStyleStrategy extends AbstractStyleStrategy {
		
		/**
		*	Creates a <code>ManualStyleStrategy</code> instance.
		*/
		public function ManualStyleStrategy()
		{
			super();
		}
		
		/**
		*	Applies the styles stored in the style sheet associated
		*	with this strategy to the target style aware object.
		*	
		*	@param target The target to apply styles to.
		*	
		*	@return An array of the styles that were applied. If the
		*	style sheet associated with this strategy is null the returned
		*	array will be null. If no styles were located in the style sheet
		*	this method will return an empty array.
		*/
		public function apply( target:IStyleAware ):Array
		{
			return applyStyles( target );
		}
	}
}