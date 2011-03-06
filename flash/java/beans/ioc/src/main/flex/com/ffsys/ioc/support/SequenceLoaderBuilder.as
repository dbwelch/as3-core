package com.ffsys.ioc.support
{
	import com.ffsys.utils.string.AddressUtils;
	
	/**
	*	A loader builder implementation that generates a
	* 	range of files from a start number to an end number.
	* 
	* 	This implementation will generate a file list entry
	* 	for the <code>start</code> and <code>end</code> values
	* 	as well as for every integer in between.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class SequenceLoaderBuilder extends LoaderBuilder
	{
		private var _start:uint;
		private var _end:uint;
		private var _fileNamePrefix:String;
	
		/**
		* 	Creates a <code>SequenceLoaderBuilder</code> instance.
		*/
		public function SequenceLoaderBuilder()
		{
			super();
		}
		
		/**
		* 	The start number for the file range.
		*/
		public function get start():uint
		{
			return _start;
		}
		
		public function set start( value:uint ):void
		{
			_start = value;
		}
		
		/**
		* 	The end number for the file range.
		*/
		public function get end():uint
		{
			return _end;
		}
		
		public function set end( value:uint ):void
		{
			_end = value;
		}
		
		/**
		* 	A prefix to use before the numeric value
		* 	when generating the file name.
		*/
		public function get fileNamePrefix():String
		{
			return _fileNamePrefix;
		}
		
		public function set fileNamePrefix(	value:String ):void
		{
			_fileNamePrefix = value;
		}
	
		/**
		* 	@inheritDoc
		*/
		override public function getFileList():Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			if( ( this.start != this.end ) )
			{
				var s:uint = ( this.start < this.end ) ? this.start : this.end;
				var e:uint = ( this.start < this.end ) ? this.end : this.start;
				var i:int = 0;
				var amount:Number = ( e - s ) + 1;
				var filler:Vector.<uint> = new Vector.<uint>();
				for( i = 0;i < amount;i++ )
				{
					filler.push( s + i );
				}
				
				//reverse
				if( !( this.start < this.end ) )
				{
					filler.reverse();
				}
				
				var num:uint;
				var file:String = null;				
				for( i = 0;i < filler.length;i++ )
				{
					num = filler[ i ];
					if( this.prefix != null )
					{
						if( this.fileNamePrefix == null )
						{
							file = AddressUtils.concatenate( prefix, "" + num );
						}else{
							file = AddressUtils.concatenate( prefix, fileNamePrefix + num );
						}
					}
					file += "." + this.extension;
					output.push( file );
				}
			}
			return output;
		}
	}
}