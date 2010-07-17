package com.ffsys.swat.configuration {
	
	import com.ffsys.utils.collections.properties.PropertyCollection;
	
	/**
	*	Encapsulates arbritrary settings for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class Settings extends PropertyCollection
		implements ISettings {
		
		/**
		*	Creates a <code>Settings</code> instance.
		*/
		public function Settings()
		{
			super();
		}
	}
}