package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that can
	*	be cloned.
	*	
	*	In addition to the interface methods you
	*	should also declare a <code>clone</code>
	*	method which should be of the correct type.
	*	
	*	You can declare this <code>clone</code> method
	*	in a sub-interface if necessary.
	*	
	*	Implementing this interface enables sub classes to
	*	manipulate the cloning process allowing constructor
	*	arguments to change while maintaining strict
	*	typing of the <code>clone</code> method return value.
	*	
	*	Note that <code>getCloneInstance</code> can
	*	be overriden in sub classes if a sub class
	*	needs to provide different constructor arguments.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IClone {
		
		/**
		*	Should return the <code>Class</code> used
		*	to correctly clone this instance.
		*	
		*	@return The <code>Class</code> of this instance.
		*/
		function getCloneClass():Class;
		
		/**
		*	Should create a cloned instance
		*	using the <code>Class</code> returned
		*	from <code>getCloneClass</code>.
		*	
		*	@return The cloned instance.
		*/
		function getCloneInstance():Object;
	}	
}