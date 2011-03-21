package org.flashx.io.xml {
	
	/**
	*	Encapsulates the options available when
	*	serializing to XML.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.05.2007
	*/
	public class SerializeOptions extends Object {
		
		/**
		*	@private	
		*/
		private var _simpleMode:Boolean;
		
		/**
		*	@private	
		*/		
		private var _classNameMode:Boolean;
		
		/**
		*	@private	
		*/
		private var _classAttribute:Boolean;


		/**
		*	@private	
		*/
		private var _ignorePrimitiveClassAttribute:Boolean;

		/**
		*	@private	
		*/
		private var _cdataEnabled:Boolean;

		/**
		*	@private	
		*/
		private var _blobEnabled:Boolean;
		
		public function SerializeOptions(
			simpleMode:Boolean = true,
			classNameMode:Boolean = false,
			classAttribute:Boolean = true,
			cdataEnabled:Boolean = false,
			blobEnabled:Boolean = false )
		{
			super();
			
			_simpleMode = simpleMode;
			_classNameMode = classNameMode;
			_classAttribute = classAttribute;
			_cdataEnabled = cdataEnabled;
			_blobEnabled = blobEnabled;
			
			_ignorePrimitiveClassAttribute = true;
			
			//_oscTypeAttribute = false;
		}
		
		public function set simpleMode( val:Boolean ):void
		{
			_simpleMode = val;
		}
		
		public function get simpleMode():Boolean
		{
			return _simpleMode;
		}
		
		/*
		private var _oscMode:Boolean;
		public function set osc( val:Boolean ):void
		{
			_oscMode = val;
			
			_simpleMode = false;
			_classNameMode = true;
			_classAttribute = false;
			_cdataEnabled = true;
			_blobEnabled = false;
		}
		
		public function get osc():Boolean
		{
			return _oscMode;
		}
		*/
		
		public function set classNameMode( val:Boolean ):void
		{
			_classNameMode = val;
		}
		
		public function get classNameMode():Boolean
		{
			return _classNameMode;
		}		
		
		/*
		private var _oscTypeAttribute:Boolean;
		public function set oscTypeAttribute( val:Boolean ):void
		{
			_oscTypeAttribute = val;
		}
		
		public function get oscTypeAttribute():Boolean
		{
			return _oscTypeAttribute;
		}
		*/
				
		public function set classAttribute( val:Boolean ):void
		{
			_classAttribute = val;
		}
		
		public function get classAttribute():Boolean
		{
			return _classAttribute;
		}
		
		public function set ignorePrimitiveClassAttribute( val:Boolean ):void
		{
			_ignorePrimitiveClassAttribute = val;
		}
		
		public function get ignorePrimitiveClassAttribute():Boolean
		{
			return _ignorePrimitiveClassAttribute;
		}		
				
		public function set cdataEnabled( val:Boolean ):void
		{
			_cdataEnabled = val;
		}
		
		public function get cdataEnabled():Boolean
		{
			return _cdataEnabled;
		}
				
		public function set blobEnabled( val:Boolean ):void
		{
			_blobEnabled = val;
		}
		
		public function get blobEnabled():Boolean
		{
			return _blobEnabled;
		}
	}
}