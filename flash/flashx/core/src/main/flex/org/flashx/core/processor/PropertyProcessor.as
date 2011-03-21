package org.flashx.core.processor {
	
	/**
	*	<code>IProcessor</code> implementation that
	*	looks up target <code>Object</code> instances
	*	using public member variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public class PropertyProcessor extends AbstractProcessor
		implements IPropertyProcessor {
		
		/**
		*	Creates a <code>PropertyProcessor</code>
		*	instance.
		* 
		* 	@param target The target to start processing from.
		*/
		public function PropertyProcessor( target:Object = null )
		{
			super( target );
			_parameters = new Array();
		}
	}
}