package com.ffsys.ioc.mock
{
	public class MockMethodInvocationBean extends Object
	{
		private var _called:Boolean = false;
		private var _parameters:Array;
		
		/**
		* 	An array to be assigned from a call to <code>getParameters</code>.
		*/
		public var assigned:Array;
		
		/**
		* 	Creates a <code>MockMethodInvocationBean</code> instance.
		*/
		public function MockMethodInvocationBean()
		{
			super();
		}
		
		/**
		* 	A method invoked automatically when this bean is retrieved.
		*/
		public function called( ... rest ):void
		{
			_called = true;
			_parameters = rest;
		}
		
		/**
		* 	Returns the parameters passed intact.
		*/
		public function getParameters( ... rest ):Array
		{
			return rest;
		}
		
		/**
		* 	The parameters passed the last time the <code>called</code> method was invoked.
		*/
		public function get parameters():Array
		{
			return _parameters;
		}
		
		/**
		* 	Determines whether the method <code>called</code> has been invoked.
		*/
		public function wasCalled():Boolean
		{
			return _called;
		}
	}
}