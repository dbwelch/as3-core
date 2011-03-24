package org.flashx.utils.byte {
	
	/**
	*	Byte formatter used to output hexadecimal
	*	and character values for a byte dump.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.04.2008
	*/
	public class HexByteDumpFormatter extends ByteDumpFormatter {
		
		/**
		*	Creates a <code>HexByteDumpFormatter</code> instance.
		*/
		public function HexByteDumpFormatter()
		{
			super();
			this.columns = 4;
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function format(
			byte:uint, char:String, hex:String, binary:String ):String
		{
			var str:String = hex + " (" +
				( byte > 13 ? char : "" ) + ")\t";
				
			return str;
		}
	}
}