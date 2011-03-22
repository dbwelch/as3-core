package org.flashx.ioc.support
{
	import org.flashx.utils.string.AddressUtils;
	
	/**
	*	A loader builder implementation that accepts a list
	* 	of known file names and builds a loader queue from
	* 	the list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class ListLoaderBuilder extends LoaderBuilder
	{
		private var _names:Array;
	
		/**
		* 	Creates a <code>ListLoaderBuilder</code> instance.
		*/
		public function ListLoaderBuilder()
		{
			super();
		}
		
		/**
		* 	The list of known file names.
		*/
		public function get names():Array
		{
			return _names;
		}
		
		public function set names( value:Array ):void
		{
			_names = value;
		}
	
		/**
		* 	@inheritDoc
		*/
		override public function getFileList():Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			if( this.names )
			{
				var file:String = null;
				for( var i:int = 0;i < this.names.length;i++ )
				{
					if( this.prefix != null )
					{
						file = AddressUtils.concatenate( prefix, "" + this.names[ i ] );
					}
					file += "." + this.extension;
					output.push( file );
				}
			}
			return output;
		}
	}
}