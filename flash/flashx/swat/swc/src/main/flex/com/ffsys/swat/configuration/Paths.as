package com.ffsys.swat.configuration
{
	import com.ffsys.core.address.*;
	import com.ffsys.utils.string.AddressUtils;
	
	import com.ffsys.swat.configuration.rsls.*;
	
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	* 	Encapsulates a path configuration for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.10.2010
	*/
	public class Paths extends Object
		implements IPaths
	{
		private var _absolute:Boolean = false;
		
		private var _base:String = "assets";
		private var _common:String = "common";
		private var _locales:String = "locales";
		private var _locale:String;
		
		/**
		* 	Creates a <code>Paths</code> instance.
		*/
		public function Paths()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get absolute():Boolean
		{
			return _absolute;
		}
		
		public function set absolute( absolute:Boolean ):void
		{
			_absolute = absolute;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get base():String
		{
			return _base;
		}
		
		public function set base( base:String ):void
		{
			_base = base;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get common():String
		{
			return _common;
		}

		public function set common( common:String ):void
		{
			_common = common;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get locales():String
		{
			return _locales;
		}

		public function set locales( locales:String ):void
		{
			_locales = locales;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get locale():String
		{
			return _locale;
		}

		public function set locale( locale:String ):void
		{
			_locale = locale;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getLocalePath( locale:IConfigurationLocale ):String
		{
			return join( [ base, locales, locale.prefix ] );
		}
		
		/**
		*	@inheritDoc
		*/
		public function join( parts:Array, file:String = null ):String
		{
			if( parts == null )
			{
				throw new Error( "Cannot join a path with no path elements." );
			}
			
			parts = parts.filter( filter, null );
			var address:IAddressPath = new AddressPath(
				null, AddressUtils.DELIMITER );
				
			var output:String = address.join( parts );
			
			if( file )
			{
				output += AddressUtils.DELIMITER + file;
			}
			
			output = output.replace( /\/{2,}/g, AddressUtils.DELIMITER );
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function translate():IPaths
		{
			var paths:IPaths = clone();
			paths.common = join( [ base, common ] );
			paths.locales = join( [ base, locales ] );
			return paths;
		}
		
		/**
		*	Gets the implementation that this object will be cloned to.
		*	
		*	Allows sub-classes to override this method and return
		*	the correct implementation to clone into.
		*	
		*	@return The instance to clone into.
		*/
		protected function getCloneInstance():IPaths
		{
			return new Paths();
		}
		
		/**
		*	@inheritDoc
		*/
		public function clone():IPaths
		{
			var paths:IPaths = getCloneInstance();
			paths.absolute = this.absolute;
			paths.base = this.base;
			paths.common = this.common;
			paths.locales = this.locales;
			paths.locale = this.locale;
			return paths;
		}
		
		/**
		*	@private
		*	
		*	Performs filtering of array values on the array
		*	passed to join to ignore empty strings.	
		*/
		private function filter( element:*, index:int, arr:Array ):Boolean
		{
			if( element is String
				&& ( element as String ).length > 0 )
			{
				return true;
			}
			
			return false;
		}		
	}
}