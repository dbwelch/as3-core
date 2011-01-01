package com.ffsys.ui.runtime {

	import flash.display.DisplayObject;
	import com.ffsys.ui.containers.Container;
	
	/**
	*	A document is the top level view that the loaded
	*	view definition document is rendered into.
	*	
	*	This object that will be added to the parent
	*	display list object specified when the call to
	*	load the runtime view was made.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class Document extends Container
		implements IDocument {
			
		private var _binding:Object = new Object();
		private var _identifiers:Object = new Object();
		
		/**
		*	Creates a <code>Document</code> instance.
		*/
		public function Document()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get binding():Object
		{
			return _binding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get identifiers():Object
		{
			return _identifiers;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getElementById( id:String ):DisplayObject
		{
			return _identifiers[ id ];
		}
		
		/**
		* 	@inheritDoc
		*/		
		override public function getElementsByMatch( re:RegExp ):Vector.<DisplayObject>
		{
			var output:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			if( re != null )
			{
				var id:String = null;
				var display:DisplayObject = null;
				for( id in _identifiers )
				{
					if( re.test( id ) )
					{
						display = _identifiers[ id ] as DisplayObject;
						if( display != null )
						{
							output.push( display );
						}
					}
				}
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_binding = null;
			_identifiers = null;
		}
	}
}