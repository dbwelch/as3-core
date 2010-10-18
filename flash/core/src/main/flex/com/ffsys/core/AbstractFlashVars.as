package com.ffsys.core {
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	
	/**
	*	Gathers data passed into the movie using
	*	flash variables.
	*	
	*	All parameters passed into the movie are set
	*	as properties on this instance, provided this
	*	instance has a property matching the name of
	*	the parameter passed in via flash variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.10.2007
	*/
	public class AbstractFlashVars extends Object
		implements IFlashVariables {
		
		private var _parameters:Object;
		
		/**
		*	Creates a new instance with a <code>root</code>
		*	<code>DisplayObject</code> which should contain
		*	the flash vars parameters to extract.
		*	
		*	@param root The root <code>DisplayObject</code> instance.
		*/
		public function AbstractFlashVars(
			root:DisplayObject = null )
		{
			super();
			
			if( root )
			{
				initialize( root );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parameters():Object
		{
			return _parameters;
		}
		
		/**
		*	Initializes all available flash variables
		*	as properties of this instance if this instance
		*	has a property that corresponds to the variable name.
		*	
		*	@param root The root <code>DisplayObject</code> instance.
		*/
		protected function initialize( root:DisplayObject ):void
		{
			try {
				_parameters = LoaderInfo( root.loaderInfo ).parameters;
			}catch( e:Error )
			{
				throw new Error( "Could not get flash variables parameters from " + root );
			}
			
		    var key:String;
		    var value:String;
		    for( key in parameters )
			{
		        value = String( parameters[ key ] );
		        
				if( this.hasOwnProperty( key ) )
				{
					value = convert( key, value );
					try
					{
						this[ key ] = value;
					}catch( e:Error )
					{
						throw new Error( "Could not assign flash variable "
							+ "'" + key + "', with value '" + value + "'." );
					}
				}
		    }
		}
		
		/**
		*	Allows the string property values to be converted prior
		*	to attempting to set the property on this instance.
		*	
		*	The default implementation simply returns the value intact,
		*	sub-classes can override this method to perform type conversion
		*	prior to setting the property.
		*	
		*	@param name The name of the property about to be set.
		*	@param value The value for the property.
		*	
		*	@return The converted value of the original value.
		*/
		protected function convert( name:String, value:String ):*
		{
			return value;
		}
	}
}