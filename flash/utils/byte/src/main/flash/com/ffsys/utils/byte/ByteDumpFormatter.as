package com.ffsys.utils.byte {
	
	/**
	*	Default formatter when dumping
	*	binary representations to a legible
	*	<code>String</code> format.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.04.2008
	*/
	public class ByteDumpFormatter extends Object
		implements IByteDumpFormatter {
		
		/**
		*	@private	
		*/
		private var _columns:int;
		
		/**
		*	Creates a <code>ByteDumpFormatter</code> instance.
		*/
		public function ByteDumpFormatter()
		{
			super();
			this.columns = 2;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function format(
			byte:uint, char:String, hex:String, binary:String ):String
		{
			var str:String = byte + "\t" + binary +
				" " + hex + " " +
				( byte > 13 ? char : "" ) + "\t\t";
				
			return str;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set columns( val:int ):void
		{
			_columns = val;
		}
		
		public function get columns():int
		{
			return _columns;
		}
	}
}