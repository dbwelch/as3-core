package com.ffsys.asdoc.interfaces
{
	import flash.display.Sprite;
	
	import com.ffsys.core.IStringIdentifier;

	/**
	*	An interface for the <em>actionscript documentation</em> test package.
	* 
	* 	@see com.ffsys.core.IStringIdentifier
	* 	@see flash.display.Sprite
	* 	@see com.ffsys.asdoc.AsdocSuper
	* 	@see com.ffsys.asdoc.AsdocTest
	* 	@see com.ffsys.asdoc
	* 	@see com.ffsys.asdoc.AsdocSuper#sprite
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.12.2010
	*/
	public interface IAsdocObject extends IStringIdentifier
	{
		/**
		* 	Retrieves an empty sprite.
		*/
		function get sprite():Sprite;
	}
}