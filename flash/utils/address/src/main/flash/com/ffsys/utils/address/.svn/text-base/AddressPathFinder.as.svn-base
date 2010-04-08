package com.ffsys.utils.address {
	
	/**
	*	Finds target instance(s) based upon a given
	*	<code>IAddressPath</code> and <code>target</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.12.2007
	*/
	public class AddressPathFinder extends Object
		implements IAddressPathFinder {
			
		/**
		*	@private	
		*/
		protected var _addressPath:IAddressPath;
		
		/**
		*	@private	
		*/
		protected var _strict:Boolean;
		
		/**
		*	Creates a new instance with an <code>IAddressPath</code>
		*	to use when performing find operations.
		*	
		*	@param addressPath The <code>IAddressPath</code> to use for find operations.
		*	@param strict A <code>Boolean</code> indicating whether
		*	find operations should run in a <code>strict</code> manner.
		*/
		public function AddressPathFinder(
			addressPath:IAddressPath,
			strict:Boolean = false )
		{
			super();
			this.addressPath = addressPath;
			this.strict = strict;
		}
		
		/**
		*	The <code>IAddressPath</code> that this instance
		*	is using to perform find operations.
		*/
		public function set addressPath( val:IAddressPath ):void
		{	
			_addressPath = val;
		}
		
		public function get addressPath():IAddressPath
		{
			return _addressPath;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set strict( val:Boolean ):void
		{
			_strict = val;
		}
		
		public function get strict():Boolean
		{
			return _strict;
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function find(
			target:Object,
			methodName:String = null ):Object
		{
			//
			if( !target )
			{
				return null;
			}
			
			var elements:Array = findPathElements( target, methodName );
			
			if( !elements.length )
			{
				return null;
			}
			
			//can be null at this point if not in strict mode
			return elements[ elements.length - 1 ];
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function findPathElements(
			target:Object,
			methodName:String = null ):Array
		{
			if( !target || !addressPath )
			{
				return new Array();
			}
			
			var targets:Array = new Array();
			
			var element:String;
			for each( element in addressPath )
			{
				target = findPathElement( target, element, methodName );
				targets.push( target );
			}
			
			return targets;			
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function findPathElement(
			target:Object,
			element:String,
			methodName:String ):Object
		{
			if( target )
			{
				var hasProperty:Boolean = Object( target ).hasOwnProperty( element );
				
				
				if( methodName )
				{
					hasProperty = Object( target ).hasOwnProperty( methodName );
				}
				
				if( hasProperty )
				{
					if( methodName )
					{
						//method call attempt
						try {
							return target[ methodName ].apply( target, [ element ] );
						}catch( e:Error )
						{
							if( strict )
							{
								throw new Error(
									"IAddressPath, could not find element '" +
									 element + "' " +
									"with method '" + methodName + "'\n\n" + e.toString() );
							}
							
							return null;
						}
						
					}else{
						//straight property lookup
						return target[ element ];
					}
			
				}
			
			}
			
			return null;
		}	
	}
}