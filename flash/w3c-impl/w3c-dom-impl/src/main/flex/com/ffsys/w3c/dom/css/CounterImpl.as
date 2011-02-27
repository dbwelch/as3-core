package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.Counter;
	
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	A counter implementation.
	*/
	public class CounterImpl extends ElementImpl
		implements Counter
	{
		private var _identifier:String;
		private var _listStyle:String;
		private var _separator:String;
		
		/**
		* 	Creates a <code>CounterImpl</code> instance.
		* 
		* 	@param identifier The counter identifier.
		* 	@param separator The counter separator.
		* 	@param listStyle The counter list style.
		*/
		public function CounterImpl(
			identifier:String = null,
			separator:String = null,
			listStyle:String = null )
		{
			super();
			_identifier = identifier;
			_separator = separator;
			_listStyle = listStyle;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get identifier():String
		{
			return _identifier;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get listStyle():String
		{
			return _listStyle;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get separator():String
		{
			return _separator;
		}		
	}
}