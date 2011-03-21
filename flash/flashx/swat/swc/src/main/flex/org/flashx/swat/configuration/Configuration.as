package org.flashx.swat.configuration {
	
	/**
	*	Represents the application configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class Configuration extends ConfigurationElement
		implements IConfiguration {
			
		private var _meta:ApplicationMeta;
		
		/**
		*	Creates a <code>Configuration</code> instance.
		*/
		public function Configuration()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set meta( val:ApplicationMeta ):void
		{
			_meta = val;
		}
		
		public function get meta():ApplicationMeta
		{
			if( !_meta )
			{
				_meta = new ApplicationMeta();
			}
			
			return _meta;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_meta = null;
		}		
	}
}