package java.lang
{
	
	/**
	* 	A CharSequence is a readable sequence of char values.
	* 
	* 	This interface provides uniform, read-only access to
	* 	many different kinds of char sequences. A char value
	* 	represents a character in the Basic Multilingual Plane
	* 	(BMP) or a surrogate. Refer to Unicode Character
	* 	Representation for details.
	* 
	* 	This interface does not refine the general contracts
	* 	of the equals and hashCode methods. The result of
	* 	comparing two objects that implement CharSequence is
	* 	therefore, in general, undefined. Each object may be
	* 	implemented by a different class, and there is no
	* 	guarantee that each class will be capable of testing
	* 	its instances for equality with those of the other.
	* 	It is therefore inappropriate to use arbitrary
	* 	CharSequence instances as elements in a set or
	* 	as keys in a map
	*/
	public interface CharSequence
	{
		
		function charAt( index:int ):Character;
		
		function length():int;
		
		function subSequence( start:int, end:int ):CharSequence;
		
		function toString():String;
	}
}